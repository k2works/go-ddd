package postgres

import (
	"github.com/google/uuid"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"github.com/sklinkert/go-ddd/internal/domain/repositories"
	"gorm.io/gorm"
)

// GormProductRepository implements the ProductRepository interface using GORM v2
type GormProductRepository struct {
	db *gorm.DB
}

// NewGormProductRepository creates a new GormProductRepository
func NewGormProductRepository(db *gorm.DB) repositories.ProductRepository {
	return &GormProductRepository{db: db}
}

// Create creates a new product
func (repo *GormProductRepository) Create(product *entities.ValidatedProduct) (*entities.Product, error) {
	// Map domain entity to DB model
	dbProduct := toDBProduct(product)

	if err := repo.db.Create(dbProduct).Error; err != nil {
		return nil, err
	}

	// Read row from DB to never return different data than persisted
	return repo.FindById(dbProduct.Id)
}

// FindById finds a product by ID
func (repo *GormProductRepository) FindById(id uuid.UUID) (*entities.Product, error) {
	var dbProduct Product
	if err := repo.db.Preload("Seller").First(&dbProduct, id).Error; err != nil {
		return nil, err
	}

	// Map back to domain entity
	return fromDBProduct(&dbProduct), nil
}

// FindAll finds all products
func (repo *GormProductRepository) FindAll() ([]*entities.Product, error) {
	var dbProducts []Product

	if err := repo.db.Preload("Seller").Find(&dbProducts).Error; err != nil {
		return nil, err
	}

	products := make([]*entities.Product, len(dbProducts))
	for i, dbProduct := range dbProducts {
		products[i] = fromDBProduct(&dbProduct)
	}
	return products, nil
}

// Update updates a product
func (repo *GormProductRepository) Update(product *entities.ValidatedProduct) (*entities.Product, error) {
	dbProduct := toDBProduct(product)
	err := repo.db.Model(&Product{}).Where("id = ?", dbProduct.Id).Updates(dbProduct).Error
	if err != nil {
		return nil, err
	}

	// Read row from DB to never return different data than persisted
	return repo.FindById(dbProduct.Id)
}

// Delete deletes a product
func (repo *GormProductRepository) Delete(id uuid.UUID) error {
	return repo.db.Delete(&Product{}, id).Error
}
