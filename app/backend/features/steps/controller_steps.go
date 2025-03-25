package steps

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"github.com/cucumber/godog"
	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
	"github.com/sklinkert/go-ddd/internal/application/command"
	"github.com/sklinkert/go-ddd/internal/application/interfaces"
	"github.com/sklinkert/go-ddd/internal/application/services"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"github.com/sklinkert/go-ddd/internal/infrastructure/db/postgres"
	"github.com/sklinkert/go-ddd/internal/interface/api/rest"
	"github.com/sklinkert/go-ddd/internal/interface/api/rest/dto/response"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
	pgdriver "gorm.io/driver/postgres"
	"gorm.io/gorm"
	"net/http"
	"net/http/httptest"
	"strconv"
	"strings"
	"time"
)

// ControllerContext holds the state for controller-related steps
type ControllerContext struct {
	productService    interfaces.ProductService
	sellerService     interfaces.SellerService
	echoInstance      *echo.Echo
	productController *rest.ProductController
	requestBody       map[string]interface{}
	response          *httptest.ResponseRecorder
	products          []*entities.Product
	db                *gorm.DB
	container         testcontainers.Container
	ctx               context.Context
}

// NewControllerContext creates a new ControllerContext
func NewControllerContext() *ControllerContext {
	return &ControllerContext{
		ctx: context.Background(),
	}
}

// setupTestDatabase sets up a test database using TestContainers
func (c *ControllerContext) setupTestDatabase() error {
	// Define PostgreSQL container
	pgReq := testcontainers.ContainerRequest{
		Image:        "postgres:13",
		ExposedPorts: []string{"5432/tcp"},
		Env: map[string]string{
			"POSTGRES_USER":     "testuser",
			"POSTGRES_PASSWORD": "testpass",
			"POSTGRES_DB":       "testdb",
		},
		WaitingFor: wait.ForLog("database system is ready to accept connections").
			WithOccurrence(2).WithStartupTimeout(5 * time.Second),
	}

	// Start PostgreSQL container
	container, err := testcontainers.GenericContainer(c.ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: pgReq,
		Started:          true,
	})
	if err != nil {
		return fmt.Errorf("failed to start PostgreSQL container: %w", err)
	}
	c.container = container

	// Get container host and port
	host, err := container.Host(c.ctx)
	if err != nil {
		return fmt.Errorf("failed to get PostgreSQL container host: %w", err)
	}

	port, err := container.MappedPort(c.ctx, "5432")
	if err != nil {
		return fmt.Errorf("failed to get PostgreSQL container port: %w", err)
	}

	// Create connection string
	dsn := fmt.Sprintf("host=%s port=%s user=testuser password=testpass dbname=testdb sslmode=disable", host, port.Port())

	// Connect to the PostgreSQL database
	db, err := gorm.Open(pgdriver.Open(dsn), &gorm.Config{})
	if err != nil {
		return fmt.Errorf("failed to connect to database: %w", err)
	}
	c.db = db

	// AutoMigrate our models
	err = db.AutoMigrate(&postgres.Product{}, &postgres.Seller{})
	if err != nil {
		return fmt.Errorf("failed to migrate database: %w", err)
	}

	return nil
}

// RegisterSteps registers the controller steps with the godog suite
func (c *ControllerContext) RegisterSteps(ctx *godog.ScenarioContext) {
	// Japanese step definitions
	ctx.Step(`^APIのための商品詳細を持っています$`, c.iHaveProductDetailsForAPI)
	ctx.Step(`^商品詳細を含めて"([^"]*)"にPOSTリクエストを送信します$`, c.iSendAPOSTRequestToWithTheProductDetails)
	ctx.Step(`^レスポンスステータスコードは(\d+)であるべきです$`, c.theResponseStatusCodeShouldBe)
	ctx.Step(`^レスポンスは作成された商品詳細を含むべきです$`, c.theResponseShouldContainTheCreatedProductDetails)
	ctx.Step(`^システムに商品があります$`, c.thereAreProductsInTheSystem)
	ctx.Step(`^"([^"]*)"にGETリクエストを送信します$`, c.iSendAGETRequestTo)
	ctx.Step(`^レスポンスは商品のリストを含むべきです$`, c.theResponseShouldContainAListOfProducts)
	ctx.Step(`^システムにID "([^"]*)"の商品があります$`, c.thereIsAProductWithIDInTheSystem)
	ctx.Step(`^レスポンスは商品詳細を含むべきです$`, c.theResponseShouldContainTheProductDetails)

	// Keep English step definitions for backward compatibility
	ctx.Step(`^I have product details for API$`, c.iHaveProductDetailsForAPI)
	ctx.Step(`^I send a POST request to "([^"]*)" with the product details$`, c.iSendAPOSTRequestToWithTheProductDetails)
	ctx.Step(`^the response status code should be (\d+)$`, c.theResponseStatusCodeShouldBe)
	ctx.Step(`^the response should contain the created product details$`, c.theResponseShouldContainTheCreatedProductDetails)
	ctx.Step(`^there are products in the system$`, c.thereAreProductsInTheSystem)
	ctx.Step(`^I send a GET request to "([^"]*)"$`, c.iSendAGETRequestTo)
	ctx.Step(`^the response should contain a list of products$`, c.theResponseShouldContainAListOfProducts)
	ctx.Step(`^there is a product with ID "([^"]*)" in the system$`, c.thereIsAProductWithIDInTheSystem)
	ctx.Step(`^the response should contain the product details$`, c.theResponseShouldContainTheProductDetails)

	ctx.BeforeScenario(func(*godog.Scenario) {
		if err := c.setupController(); err != nil {
			panic(fmt.Sprintf("Failed to setup controller: %v", err))
		}
	})

	ctx.AfterScenario(func(*godog.Scenario, error) {
		// Clean up database
		if c.db != nil {
			c.db.Exec("DELETE FROM products")
			c.db.Exec("DELETE FROM sellers")
		}

		// Stop and remove PostgreSQL container
		if c.container != nil {
			if err := c.container.Terminate(c.ctx); err != nil {
				fmt.Printf("Failed to terminate container: %v\n", err)
			}
		}
	})
}

func (c *ControllerContext) setupController() error {
	// Setup test database with TestContainers
	if err := c.setupTestDatabase(); err != nil {
		return err
	}

	// Create repositories
	productRepo := postgres.NewGormProductRepository(c.db)
	sellerRepo := postgres.NewGormSellerRepository(c.db)

	// Create services
	c.productService = services.NewProductService(productRepo, sellerRepo)
	c.sellerService = services.NewSellerService(sellerRepo)

	// Create a new Echo instance
	c.echoInstance = echo.New()

	// Create a new product controller
	c.productController = rest.NewProductController(c.echoInstance, c.productService)

	// Initialize the response recorder
	c.response = httptest.NewRecorder()

	return nil
}

func (c *ControllerContext) iHaveProductDetailsForAPI(table *godog.Table) error {
	c.requestBody = make(map[string]interface{})

	// Skip the header row
	for i := 1; i < len(table.Rows); i++ {
		row := table.Rows[i]
		for j, cell := range row.Cells {
			header := table.Rows[0].Cells[j].Value
			// Use proper JSON field names with capitalized first letter
			switch header {
			case "name", "名前":
				c.requestBody["Name"] = cell.Value
			case "price", "価格":
				// Convert price to float64
				price, err := strconv.ParseFloat(cell.Value, 64)
				if err != nil {
					return fmt.Errorf("failed to parse price: %w", err)
				}
				c.requestBody["Price"] = price
			case "sellerId", "出品者ID":
				c.requestBody["SellerId"] = cell.Value
			default:
				c.requestBody[header] = cell.Value
			}
		}
	}

	return nil
}

func (c *ControllerContext) iSendAPOSTRequestToWithTheProductDetails(path string) error {
	// Create a seller first if the request body contains a seller ID
	if sellerID, ok := c.requestBody["SellerId"].(string); ok && sellerID == "00000000-0000-0000-0000-000000000001" {
		// Create a seller
		sellerName := "Test Seller " + uuid.New().String()
		sellerResult, err := c.sellerService.CreateSeller(&command.CreateSellerCommand{
			Name: sellerName,
		})
		if err != nil {
			return fmt.Errorf("failed to create seller: %w", err)
		}

		// Update the seller ID in the request body
		c.requestBody["SellerId"] = sellerResult.Result.Id.String()
	}

	// Convert request body to JSON
	jsonBody, err := json.Marshal(c.requestBody)
	if err != nil {
		return fmt.Errorf("failed to marshal request body: %w", err)
	}

	// Create a new HTTP request
	req := httptest.NewRequest(http.MethodPost, path, bytes.NewReader(jsonBody))
	req.Header.Set(echo.HeaderContentType, echo.MIMEApplicationJSON)

	// Create a new response recorder
	c.response = httptest.NewRecorder()

	// Serve the request
	c.echoInstance.ServeHTTP(c.response, req)

	return nil
}

func (c *ControllerContext) theResponseStatusCodeShouldBe(statusCode int) error {
	if c.response.Code != statusCode {
		return fmt.Errorf("expected status code %d but got %d", statusCode, c.response.Code)
	}
	return nil
}

func (c *ControllerContext) theResponseShouldContainTheCreatedProductDetails() error {
	var productResponse response.ProductResponse
	if err := json.Unmarshal(c.response.Body.Bytes(), &productResponse); err != nil {
		return fmt.Errorf("failed to unmarshal response body: %w", err)
	}

	// Check that the response contains the expected fields
	expectedName, ok := c.requestBody["Name"].(string)
	if !ok {
		return fmt.Errorf("expected Name to be a string")
	}

	if productResponse.Name != expectedName {
		return fmt.Errorf("expected product name %s but got %s", expectedName, productResponse.Name)
	}

	return nil
}

func (c *ControllerContext) thereAreProductsInTheSystem() error {
	// Create a seller first
	sellerName := "Test Seller " + uuid.New().String()
	sellerResult, err := c.sellerService.CreateSeller(&command.CreateSellerCommand{
		Name: sellerName,
	})
	if err != nil {
		return fmt.Errorf("failed to create seller: %w", err)
	}

	// Create multiple products
	for i := 1; i <= 2; i++ {
		productName := fmt.Sprintf("Product %d", i)
		productPrice := float64(i*10) + 0.99
		createProductCmd := &command.CreateProductCommand{
			Name:     productName,
			Price:    productPrice,
			SellerId: sellerResult.Result.Id,
		}

		_, err := c.productService.CreateProduct(createProductCmd)
		if err != nil {
			return fmt.Errorf("failed to create product: %w", err)
		}
	}

	return nil
}

func (c *ControllerContext) iSendAGETRequestTo(path string) error {
	// If the path contains a product ID placeholder, replace it with the actual product ID
	if c.products != nil && len(c.products) > 0 && strings.Contains(path, "00000000-0000-0000-0000-000000000001") {
		path = strings.Replace(path, "00000000-0000-0000-0000-000000000001", c.products[0].Id.String(), 1)
	}

	// Create a new HTTP request
	req := httptest.NewRequest(http.MethodGet, path, nil)

	// Create a new response recorder
	c.response = httptest.NewRecorder()

	// Serve the request
	c.echoInstance.ServeHTTP(c.response, req)

	return nil
}

func (c *ControllerContext) theResponseShouldContainAListOfProducts() error {
	c.products = make([]*entities.Product, 2)
	var listResponse response.ListProductsResponse
	if err := json.Unmarshal(c.response.Body.Bytes(), &listResponse); err != nil {
		return fmt.Errorf("failed to unmarshal response body: %w", err)
	}

	// Check that the response contains the expected number of products
	if len(listResponse.Products) != len(c.products) {
		return fmt.Errorf("expected %d products but got %d", len(c.products), len(listResponse.Products))
	}

	return nil
}

func (c *ControllerContext) thereIsAProductWithIDInTheSystem(id string) error {
	// For BDD tests with TestContainers, we need to create a product and use its actual ID
	// instead of trying to use a fixed ID from the feature file

	// Create a seller first
	sellerName := "Test Seller " + uuid.New().String()
	sellerResult, err := c.sellerService.CreateSeller(&command.CreateSellerCommand{
		Name: sellerName,
	})
	if err != nil {
		return fmt.Errorf("failed to create seller: %w", err)
	}

	// Create a product
	productName := "Test Product"
	productPrice := 10.99
	createProductCmd := &command.CreateProductCommand{
		Name:     productName,
		Price:    productPrice,
		SellerId: sellerResult.Result.Id,
	}

	createResult, err := c.productService.CreateProduct(createProductCmd)
	if err != nil {
		return fmt.Errorf("failed to create product: %w", err)
	}

	// Store the created product ID for later use
	createdID := createResult.Result.Id

	// Modify the path in the next step to use the actual created product ID
	c.products = []*entities.Product{
		{
			Id:    createdID,
			Name:  productName,
			Price: productPrice,
		},
	}

	return nil
}

func (c *ControllerContext) theResponseShouldContainTheProductDetails() error {
	var productResponse response.ProductResponse
	if err := json.Unmarshal(c.response.Body.Bytes(), &productResponse); err != nil {
		return fmt.Errorf("failed to unmarshal response body: %w", err)
	}

	// Check that the response contains the expected fields
	if productResponse.Name != "Test Product" {
		return fmt.Errorf("expected product name %s but got %s", "Test Product", productResponse.Name)
	}

	return nil
}

// MockProductService has been replaced with a real ProductService using TestContainers
