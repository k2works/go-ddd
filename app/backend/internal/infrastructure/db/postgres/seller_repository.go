package postgres

import (
	"github.com/google/uuid"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"github.com/sklinkert/go-ddd/internal/domain/repositories"
	"gorm.io/gorm"
)

// GormSellerRepository implements the SellerRepository interface using GORM v2
type GormSellerRepository struct {
	db *gorm.DB
}

// NewGormSellerRepository creates a new GormSellerRepository
func NewGormSellerRepository(db *gorm.DB) repositories.SellerRepository {
	return &GormSellerRepository{db: db}
}

// Create creates a new seller
func (repo *GormSellerRepository) Create(seller *entities.ValidatedSeller) (*entities.Seller, error) {
	dbSeller := toDBSeller(seller)

	if err := repo.db.Create(dbSeller).Error; err != nil {
		return nil, err
	}

	return repo.FindById(dbSeller.Id)
}

// FindById finds a seller by ID
func (repo *GormSellerRepository) FindById(id uuid.UUID) (*entities.Seller, error) {
	var dbSeller Seller
	if err := repo.db.First(&dbSeller, id).Error; err != nil {
		return nil, err
	}
	return fromDBSeller(&dbSeller), nil
}

// FindAll finds all sellers
func (repo *GormSellerRepository) FindAll() ([]*entities.Seller, error) {
	var dbSellers []Seller
	if err := repo.db.Find(&dbSellers).Error; err != nil {
		return nil, err
	}

	sellers := make([]*entities.Seller, len(dbSellers))
	for i, dbSeller := range dbSellers {
		sellers[i] = fromDBSeller(&dbSeller)
	}

	return sellers, nil
}

// Update updates a seller
func (repo *GormSellerRepository) Update(seller *entities.ValidatedSeller) (*entities.Seller, error) {
	dbSeller := toDBSeller(seller)

	err := repo.db.Model(&Seller{}).Where("id = ?", dbSeller.Id).Updates(dbSeller).Error
	if err != nil {
		return nil, err
	}

	return repo.FindById(dbSeller.Id)
}

// Delete deletes a seller
func (repo *GormSellerRepository) Delete(id uuid.UUID) error {
	return repo.db.Delete(&Seller{}, id).Error
}
