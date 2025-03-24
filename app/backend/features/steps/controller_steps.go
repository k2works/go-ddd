package steps

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/cucumber/godog"
	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
	"github.com/sklinkert/go-ddd/internal/application/command"
	"github.com/sklinkert/go-ddd/internal/application/common"
	"github.com/sklinkert/go-ddd/internal/application/interfaces"
	"github.com/sklinkert/go-ddd/internal/application/query"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"github.com/sklinkert/go-ddd/internal/interface/api/rest"
	"github.com/sklinkert/go-ddd/internal/interface/api/rest/dto/response"
	"net/http"
	"net/http/httptest"
	"strconv"
	"time"
)

// ControllerContext holds the state for controller-related steps
type ControllerContext struct {
	productService    interfaces.ProductService
	echoInstance      *echo.Echo
	productController *rest.ProductController
	requestBody       map[string]interface{}
	response          *httptest.ResponseRecorder
	products          []*entities.Product
}

// NewControllerContext creates a new ControllerContext
func NewControllerContext() *ControllerContext {
	return &ControllerContext{}
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
		c.setupController()
	})
}

func (c *ControllerContext) setupController() {
	// Create a mock product service
	c.productService = &MockProductService{}

	// Create a new Echo instance
	c.echoInstance = echo.New()

	// Create a new product controller
	c.productController = rest.NewProductController(c.echoInstance, c.productService)

	// Initialize the response recorder
	c.response = httptest.NewRecorder()
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
	// Create some sample products
	seller := entities.NewSeller("Test Seller")
	validatedSeller, err := entities.NewValidatedSeller(seller)
	if err != nil {
		return fmt.Errorf("failed to validate seller: %w", err)
	}

	product1 := entities.NewProduct("Product 1", 10.99, *validatedSeller)
	product2 := entities.NewProduct("Product 2", 20.99, *validatedSeller)

	c.products = []*entities.Product{product1, product2}

	// Set up the mock product service to return these products
	mockService := c.productService.(*MockProductService)
	mockService.Products = c.products

	return nil
}

func (c *ControllerContext) iSendAGETRequestTo(path string) error {
	// Create a new HTTP request
	req := httptest.NewRequest(http.MethodGet, path, nil)

	// Create a new response recorder
	c.response = httptest.NewRecorder()

	// Serve the request
	c.echoInstance.ServeHTTP(c.response, req)

	return nil
}

func (c *ControllerContext) theResponseShouldContainAListOfProducts() error {
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
	// Parse the ID
	productID, err := uuid.Parse(id)
	if err != nil {
		return fmt.Errorf("failed to parse product ID: %w", err)
	}

	// Create a sample product with the given ID
	seller := entities.NewSeller("Test Seller")
	validatedSeller, err := entities.NewValidatedSeller(seller)
	if err != nil {
		return fmt.Errorf("failed to validate seller: %w", err)
	}

	product := entities.NewProduct("Test Product", 10.99, *validatedSeller)
	product.Id = productID

	// Set up the mock product service to return this product
	mockService := c.productService.(*MockProductService)
	mockService.Product = product

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

// MockProductService is a mock implementation of the ProductService interface
type MockProductService struct {
	Product  *entities.Product
	Products []*entities.Product
}

// CreateProduct mocks the CreateProduct method
func (m *MockProductService) CreateProduct(productCommand *command.CreateProductCommand) (*command.CreateProductCommandResult, error) {
	// Create a sample product
	seller := entities.NewSeller("Test Seller")
	validatedSeller, _ := entities.NewValidatedSeller(seller)

	product := entities.NewProduct(productCommand.Name, productCommand.Price, *validatedSeller)

	// Convert to ProductResult
	productResult := &common.ProductResult{
		Id:    product.Id,
		Name:  product.Name,
		Price: product.Price,
		Seller: &common.SellerResult{
			Id:        validatedSeller.Id,
			Name:      validatedSeller.Name,
			CreatedAt: time.Now(),
			UpdatedAt: time.Now(),
		},
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}

	return &command.CreateProductCommandResult{
		Result: productResult,
	}, nil
}

// FindAllProducts mocks the FindAllProducts method
func (m *MockProductService) FindAllProducts() (*query.ProductQueryListResult, error) {
	// Convert products to ProductResult slice
	productResults := make([]*common.ProductResult, len(m.Products))
	for i, product := range m.Products {
		productResults[i] = &common.ProductResult{
			Id:    product.Id,
			Name:  product.Name,
			Price: product.Price,
			Seller: &common.SellerResult{
				Id:        product.Seller.Id,
				Name:      product.Seller.Name,
				CreatedAt: time.Now(),
				UpdatedAt: time.Now(),
			},
			CreatedAt: time.Now(),
			UpdatedAt: time.Now(),
		}
	}

	return &query.ProductQueryListResult{
		Result: productResults,
	}, nil
}

// FindProductById mocks the FindProductById method
func (m *MockProductService) FindProductById(id uuid.UUID) (*query.ProductQueryResult, error) {
	if m.Product != nil && m.Product.Id == id {
		// Convert to ProductResult
		productResult := &common.ProductResult{
			Id:    m.Product.Id,
			Name:  m.Product.Name,
			Price: m.Product.Price,
			Seller: &common.SellerResult{
				Id:        m.Product.Seller.Id,
				Name:      m.Product.Seller.Name,
				CreatedAt: time.Now(),
				UpdatedAt: time.Now(),
			},
			CreatedAt: time.Now(),
			UpdatedAt: time.Now(),
		}

		return &query.ProductQueryResult{
			Result: productResult,
		}, nil
	}

	return nil, nil
}
