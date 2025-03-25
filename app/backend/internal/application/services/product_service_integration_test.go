package services

import (
	"context"
	"fmt"
	"testing"
	"time"

	"github.com/google/uuid"
	"github.com/sklinkert/go-ddd/internal/application/command"
	"github.com/sklinkert/go-ddd/internal/application/common"
	"github.com/sklinkert/go-ddd/internal/application/interfaces"
	"github.com/sklinkert/go-ddd/internal/infrastructure/db/postgres"
	"github.com/stretchr/testify/assert"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
	pgdriver "gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func setupTestDatabase(t *testing.T) (*gorm.DB, func()) {
	ctx := context.Background()

	// Define PostgreSQL container
	pgReq := testcontainers.ContainerRequest{
		Image:        "postgres:15-alpine",
		ExposedPorts: []string{"5432/tcp"},
		Env: map[string]string{
			"POSTGRES_USER":     "postgres",
			"POSTGRES_PASSWORD": "postgres",
			"POSTGRES_DB":       "testdb",
		},
		WaitingFor: wait.ForLog("database system is ready to accept connections").
			WithOccurrence(2).WithStartupTimeout(5 * time.Second),
	}

	// Start PostgreSQL container
	pgContainer, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: pgReq,
		Started:          true,
	})
	if err != nil {
		t.Fatalf("Failed to start PostgreSQL container: %s", err)
	}

	// Get container host and port
	host, err := pgContainer.Host(ctx)
	if err != nil {
		t.Fatalf("Failed to get PostgreSQL container host: %s", err)
	}

	port, err := pgContainer.MappedPort(ctx, "5432")
	if err != nil {
		t.Fatalf("Failed to get PostgreSQL container port: %s", err)
	}

	// Create connection string
	dsn := fmt.Sprintf("host=%s port=%s user=postgres password=postgres dbname=testdb sslmode=disable", host, port.Port())

	// Connect to the PostgreSQL database
	database, err := gorm.Open(pgdriver.Open(dsn), &gorm.Config{})
	if err != nil {
		t.Fatalf("Failed to connect to database: %s", err)
	}

	// AutoMigrate our models
	err = database.AutoMigrate(&postgres.Product{}, &postgres.Seller{})
	if err != nil {
		t.Fatalf("Failed to migrate database: %s", err)
	}

	// Cleanup function
	cleanup := func() {
		// Clean up database
		database.Exec("DELETE FROM sellers")
		database.Exec("DELETE FROM products")

		// Stop and remove PostgreSQL container
		if err := pgContainer.Terminate(ctx); err != nil {
			t.Fatalf("Failed to terminate container: %s", err)
		}
	}

	return database, cleanup
}

func createTestSeller(t *testing.T, sellerService interfaces.SellerService) *common.SellerResult {
	sellerName := "Test Seller " + uuid.New().String()
	result, err := sellerService.CreateSeller(&command.CreateSellerCommand{
		Name: sellerName,
	})
	assert.NoError(t, err)
	assert.NotNil(t, result)
	assert.NotNil(t, result.Result)
	assert.Equal(t, sellerName, result.Result.Name)
	return result.Result
}

func TestProductService_Integration_CreateProduct(t *testing.T) {
	// Setup test database with Testcontainers
	db, cleanup := setupTestDatabase(t)
	defer cleanup()

	// Create repositories
	productRepo := postgres.NewGormProductRepository(db)
	sellerRepo := postgres.NewGormSellerRepository(db)

	// Create services
	productService := NewProductService(productRepo, sellerRepo)
	sellerService := NewSellerService(sellerRepo)

	// Create a seller first
	seller := createTestSeller(t, sellerService)

	// Test creating a product
	productName := "Test Product"
	productPrice := 99.99
	createProductCmd := &command.CreateProductCommand{
		Name:     productName,
		Price:    productPrice,
		SellerId: seller.Id,
	}

	result, err := productService.CreateProduct(createProductCmd)
	assert.NoError(t, err)
	assert.NotNil(t, result)
	assert.NotNil(t, result.Result)
	assert.Equal(t, productName, result.Result.Name)
	assert.Equal(t, productPrice, result.Result.Price)
	assert.Equal(t, seller.Id, result.Result.Seller.Id)
}

func TestProductService_Integration_FindAllProducts(t *testing.T) {
	// Setup test database with Testcontainers
	db, cleanup := setupTestDatabase(t)
	defer cleanup()

	// Create repositories
	productRepo := postgres.NewGormProductRepository(db)
	sellerRepo := postgres.NewGormSellerRepository(db)

	// Create services
	productService := NewProductService(productRepo, sellerRepo)
	sellerService := NewSellerService(sellerRepo)

	// Create a seller first
	seller := createTestSeller(t, sellerService)

	// Create multiple products
	for i := 1; i <= 3; i++ {
		productName := fmt.Sprintf("Test Product %d", i)
		productPrice := float64(i * 10)
		createProductCmd := &command.CreateProductCommand{
			Name:     productName,
			Price:    productPrice,
			SellerId: seller.Id,
		}

		_, err := productService.CreateProduct(createProductCmd)
		assert.NoError(t, err)
	}

	// Test finding all products
	result, err := productService.FindAllProducts()
	assert.NoError(t, err)
	assert.NotNil(t, result)
	assert.NotNil(t, result.Result)
	assert.Len(t, result.Result, 3)
}

func TestProductService_Integration_FindProductById(t *testing.T) {
	// Setup test database with Testcontainers
	db, cleanup := setupTestDatabase(t)
	defer cleanup()

	// Create repositories
	productRepo := postgres.NewGormProductRepository(db)
	sellerRepo := postgres.NewGormSellerRepository(db)

	// Create services
	productService := NewProductService(productRepo, sellerRepo)
	sellerService := NewSellerService(sellerRepo)

	// Create a seller first
	seller := createTestSeller(t, sellerService)

	// Create a product
	productName := "Test Product"
	productPrice := 99.99
	createProductCmd := &command.CreateProductCommand{
		Name:     productName,
		Price:    productPrice,
		SellerId: seller.Id,
	}

	createResult, err := productService.CreateProduct(createProductCmd)
	assert.NoError(t, err)
	productId := createResult.Result.Id

	// Test finding product by ID
	findResult, err := productService.FindProductById(productId)
	assert.NoError(t, err)
	assert.NotNil(t, findResult)
	assert.NotNil(t, findResult.Result)
	assert.Equal(t, productName, findResult.Result.Name)
	assert.Equal(t, productPrice, findResult.Result.Price)
	assert.Equal(t, seller.Id, findResult.Result.Seller.Id)

	// Test finding non-existent product
	_, err = productService.FindProductById(uuid.New())
	assert.Error(t, err)
}
