package services

import (
	"context"
	"fmt"
	"testing"

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

	// PostgreSQLコンテナを起動
	container, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: testcontainers.ContainerRequest{
			Image:        "postgres:13",
			ExposedPorts: []string{"5432/tcp"},
			Env: map[string]string{
				"POSTGRES_USER":     "testuser",
				"POSTGRES_PASSWORD": "testpass",
				"POSTGRES_DB":       "testdb",
			},
			WaitingFor: wait.ForLog("database system is ready to accept connections"),
		},
		Started: true,
	})
	if err != nil {
		t.Fatalf("Failed to start container: %v", err)
	}

	// コンテナのホストとポートを取得
	host, err := container.Host(ctx)
	if err != nil {
		t.Fatalf("Failed to get container host: %v", err)
	}

	port, err := container.MappedPort(ctx, "5432")
	if err != nil {
		t.Fatalf("Failed to get container port: %v", err)
	}

	// データベース接続
	dsn := fmt.Sprintf("host=%s port=%s user=testuser password=testpass dbname=testdb sslmode=disable", host, port.Port())
	db, err := gorm.Open(pgdriver.Open(dsn), &gorm.Config{})
	if err != nil {
		t.Fatalf("Failed to connect to database: %v", err)
	}

	// テーブルを作成
	err = db.AutoMigrate(&postgres.Product{}, &postgres.Seller{})
	if err != nil {
		t.Fatalf("Failed to migrate database: %v", err)
	}

	// クリーンアップ関数を返す
	cleanup := func() {
		container.Terminate(ctx)
	}

	return db, cleanup
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
