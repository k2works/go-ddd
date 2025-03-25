package services

import (
	"fmt"
	"testing"

	"github.com/google/uuid"
	"github.com/sklinkert/go-ddd/internal/application/command"
	"github.com/sklinkert/go-ddd/internal/infrastructure/db/postgres"
	"github.com/stretchr/testify/assert"
)

// We can reuse the setupTestDatabase function from product_service_integration_test.go
// since it's in the same package

func TestSellerService_Integration_CreateSeller(t *testing.T) {
	// Setup test database with Testcontainers
	db, cleanup := setupTestDatabase(t)
	defer cleanup()

	// Create repository
	sellerRepo := postgres.NewGormSellerRepository(db)

	// Create service
	sellerService := NewSellerService(sellerRepo)

	// Test creating a seller
	sellerName := "Test Seller"
	createSellerCmd := &command.CreateSellerCommand{
		Name: sellerName,
	}

	result, err := sellerService.CreateSeller(createSellerCmd)
	assert.NoError(t, err)
	assert.NotNil(t, result)
	assert.NotNil(t, result.Result)
	assert.Equal(t, sellerName, result.Result.Name)
	assert.NotEqual(t, uuid.Nil, result.Result.Id)
}

func TestSellerService_Integration_FindAllSellers(t *testing.T) {
	// Setup test database with Testcontainers
	db, cleanup := setupTestDatabase(t)
	defer cleanup()

	// Create repository
	sellerRepo := postgres.NewGormSellerRepository(db)

	// Create service
	sellerService := NewSellerService(sellerRepo)

	// Create multiple sellers
	for i := 1; i <= 3; i++ {
		sellerName := fmt.Sprintf("Test Seller %d", i)
		createSellerCmd := &command.CreateSellerCommand{
			Name: sellerName,
		}

		_, err := sellerService.CreateSeller(createSellerCmd)
		assert.NoError(t, err)
	}

	// Test finding all sellers
	result, err := sellerService.FindAllSellers()
	assert.NoError(t, err)
	assert.NotNil(t, result)
	assert.NotNil(t, result.Result)
	assert.Len(t, result.Result, 3)
}

func TestSellerService_Integration_FindSellerById(t *testing.T) {
	// Setup test database with Testcontainers
	db, cleanup := setupTestDatabase(t)
	defer cleanup()

	// Create repository
	sellerRepo := postgres.NewGormSellerRepository(db)

	// Create service
	sellerService := NewSellerService(sellerRepo)

	// Create a seller
	sellerName := "Test Seller"
	createSellerCmd := &command.CreateSellerCommand{
		Name: sellerName,
	}

	createResult, err := sellerService.CreateSeller(createSellerCmd)
	assert.NoError(t, err)
	sellerId := createResult.Result.Id

	// Test finding seller by ID
	findResult, err := sellerService.FindSellerById(sellerId)
	assert.NoError(t, err)
	assert.NotNil(t, findResult)
	assert.NotNil(t, findResult.Result)
	assert.Equal(t, sellerName, findResult.Result.Name)
	assert.Equal(t, sellerId, findResult.Result.Id)

	// Test finding non-existent seller
	_, err = sellerService.FindSellerById(uuid.New())
	assert.Error(t, err)
}

func TestSellerService_Integration_UpdateSeller(t *testing.T) {
	// Setup test database with Testcontainers
	db, cleanup := setupTestDatabase(t)
	defer cleanup()

	// Create repository
	sellerRepo := postgres.NewGormSellerRepository(db)

	// Create service
	sellerService := NewSellerService(sellerRepo)

	// Create a seller
	sellerName := "Test Seller"
	createSellerCmd := &command.CreateSellerCommand{
		Name: sellerName,
	}

	createResult, err := sellerService.CreateSeller(createSellerCmd)
	assert.NoError(t, err)
	sellerId := createResult.Result.Id

	// Test updating seller
	updatedName := "Updated Seller"
	updateSellerCmd := &command.UpdateSellerCommand{
		Id:   sellerId,
		Name: updatedName,
	}

	updateResult, err := sellerService.UpdateSeller(updateSellerCmd)
	assert.NoError(t, err)
	assert.NotNil(t, updateResult)
	assert.NotNil(t, updateResult.Result)
	assert.Equal(t, updatedName, updateResult.Result.Name)
	assert.Equal(t, sellerId, updateResult.Result.Id)

	// Verify the update by finding the seller
	findResult, err := sellerService.FindSellerById(sellerId)
	assert.NoError(t, err)
	assert.Equal(t, updatedName, findResult.Result.Name)
}

func TestSellerService_Integration_DeleteSeller(t *testing.T) {
	// Setup test database with Testcontainers
	db, cleanup := setupTestDatabase(t)
	defer cleanup()

	// Create repository
	sellerRepo := postgres.NewGormSellerRepository(db)

	// Create service
	sellerService := NewSellerService(sellerRepo)

	// Create a seller
	sellerName := "Test Seller"
	createSellerCmd := &command.CreateSellerCommand{
		Name: sellerName,
	}

	createResult, err := sellerService.CreateSeller(createSellerCmd)
	assert.NoError(t, err)
	sellerId := createResult.Result.Id

	// Test deleting seller
	err = sellerService.DeleteSeller(sellerId)
	assert.NoError(t, err)

	// Verify the deletion by trying to find the seller
	_, err = sellerService.FindSellerById(sellerId)
	assert.Error(t, err)
}
