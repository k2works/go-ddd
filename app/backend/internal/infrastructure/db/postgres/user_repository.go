package postgres

import (
	"errors"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"gorm.io/gorm"
)

// UserModel is the GORM model for users
type UserModel struct {
	ID           string `gorm:"primaryKey"`
	Email        string `gorm:"uniqueIndex"`
	PasswordHash string
	CreatedAt    int64
	UpdatedAt    int64
}

// TableName specifies the table name for UserModel
func (UserModel) TableName() string {
	return "users"
}

// GormUserRepository is a PostgreSQL implementation of the UserRepository interface
type GormUserRepository struct {
	db *gorm.DB
}

// NewGormUserRepository creates a new GormUserRepository
func NewGormUserRepository(db *gorm.DB) *GormUserRepository {
	// Ensure the users table exists
	db.AutoMigrate(&UserModel{})
	
	return &GormUserRepository{
		db: db,
	}
}

// toModel converts a User entity to a UserModel
func toModel(user *entities.User) *UserModel {
	return &UserModel{
		ID:           user.ID,
		Email:        user.Email,
		PasswordHash: user.PasswordHash,
		CreatedAt:    user.CreatedAt.Unix(),
		UpdatedAt:    user.UpdatedAt.Unix(),
	}
}

// toEntity converts a UserModel to a User entity
func toEntity(model *UserModel) *entities.User {
	user, _ := entities.NewUser(
		model.ID,
		model.Email,
		model.PasswordHash,
	)
	return user
}

// Save persists a user to the repository
func (r *GormUserRepository) Save(user *entities.User) error {
	model := toModel(user)
	return r.db.Save(model).Error
}

// FindByID retrieves a user by ID
func (r *GormUserRepository) FindByID(id string) (*entities.User, error) {
	var model UserModel
	if err := r.db.Where("id = ?", id).First(&model).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return toEntity(&model), nil
}

// FindByEmail retrieves a user by email
func (r *GormUserRepository) FindByEmail(email string) (*entities.User, error) {
	var model UserModel
	if err := r.db.Where("email = ?", email).First(&model).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return toEntity(&model), nil
}

// Delete removes a user from the repository
func (r *GormUserRepository) Delete(id string) error {
	return r.db.Delete(&UserModel{}, "id = ?", id).Error
}