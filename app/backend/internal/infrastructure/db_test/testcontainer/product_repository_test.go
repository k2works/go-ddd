package testcontainer_test

import (
	"context"
	"fmt"
	"testing"
	"time"

	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"github.com/sklinkert/go-ddd/internal/infrastructure/db/postgres"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
	pgdriver "gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func setupDatabase(t *testing.T) (*gorm.DB, func()) {
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

func TestGormProductRepository_Save(t *testing.T) {
	gormDB, cleanup := setupDatabase(t)
	defer cleanup()

	repo := postgres.NewGormProductRepository(gormDB)

	seller := getPersistedSeller(t, gormDB)
	validatedSeller, _ := entities.NewValidatedSeller(&seller.Seller)

	product := entities.NewProduct("TestProduct", 9.99, *validatedSeller)
	validProduct, _ := entities.NewValidatedProduct(product)

	_, err := repo.Create(validProduct)
	if err != nil {
		t.Errorf("Unexpected error during save: %s", err)
	}
}

func TestGormProductRepository_FindById(t *testing.T) {
	gormDB, cleanup := setupDatabase(t)
	defer cleanup()

	repo := postgres.NewGormProductRepository(gormDB)

	seller := getPersistedSeller(t, gormDB)
	validatedSeller, _ := entities.NewValidatedSeller(&seller.Seller)

	product := entities.NewProduct("TestProduct", 9.99, *validatedSeller)
	validProduct, _ := entities.NewValidatedProduct(product)
	repo.Create(validProduct)

	foundProduct, err := repo.FindById(validProduct.Id)
	if err != nil || foundProduct.Name != "TestProduct" {
		t.Error("Error fetching or product mismatch")
	}
}

func TestGormProductRepository_Update(t *testing.T) {
	gormDB, cleanup := setupDatabase(t)
	defer cleanup()

	repo := postgres.NewGormProductRepository(gormDB)

	seller := getPersistedSeller(t, gormDB)
	validatedSeller, _ := entities.NewValidatedSeller(&seller.Seller)

	product := entities.NewProduct("TestProduct", 9.99, *validatedSeller)
	validProduct, _ := entities.NewValidatedProduct(product)
	_, err := repo.Create(validProduct)
	if err != nil {
		t.Fatalf("Unexpected error during save: %s", err)
	}

	validProduct.Name = "UpdatedProduct"
	_, err = repo.Update(validProduct)
	if err != nil {
		t.Errorf("Unexpected error during update: %s", err)
	}

	updatedProduct, _ := repo.FindById(validProduct.Id)
	if updatedProduct.Name != "UpdatedProduct" {
		t.Error("UpdateName failed or fetched wrong product")
	}
}

func TestGormProductRepository_GetAll(t *testing.T) {
	gormDB, cleanup := setupDatabase(t)
	defer cleanup()

	repo := postgres.NewGormProductRepository(gormDB)

	seller := getPersistedSeller(t, gormDB)
	validatedSeller, _ := entities.NewValidatedSeller(&seller.Seller)

	product := entities.NewProduct("TestProduct", 9.99, *validatedSeller)
	validProduct, _ := entities.NewValidatedProduct(product)
	repo.Create(validProduct)

	products, err := repo.FindAll()
	if err != nil || len(products) != 1 {
		t.Error("Error fetching all products or product count mismatch")
	}
}

func TestGormProductRepository_Delete(t *testing.T) {
	gormDB, cleanup := setupDatabase(t)
	defer cleanup()

	repo := postgres.NewGormProductRepository(gormDB)

	seller := getPersistedSeller(t, gormDB)
	validatedSeller, _ := entities.NewValidatedSeller(&seller.Seller)

	product := entities.NewProduct("TestProduct", 9.99, *validatedSeller)
	validProduct, _ := entities.NewValidatedProduct(product)
	repo.Create(validProduct)

	err := repo.Delete(validProduct.Id)
	if err != nil {
		t.Errorf("Unexpected error during delete: %s", err)
	}

	_, err = repo.FindById(validProduct.Id)
	if err == nil {
		t.Error("Product should have been deleted, but was found")
	}
}

func getPersistedSeller(t *testing.T, gormDB *gorm.DB) entities.ValidatedSeller {
	seller := entities.NewSeller("TestSeller")
	validatedSeller, _ := entities.NewValidatedSeller(seller)

	repo := postgres.NewGormSellerRepository(gormDB)
	repo.Create(validatedSeller)

	return *validatedSeller
}
