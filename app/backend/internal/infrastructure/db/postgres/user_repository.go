package postgres

import (
	"errors"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"github.com/sklinkert/go-ddd/internal/domain/repositories"
	"gorm.io/gorm"
	"time"
)

// UserModel is the GORM model for users
type UserModel struct {
	ID           string `gorm:"primaryKey"`
	Username     string `gorm:"uniqueIndex"`
	Email        string `gorm:"uniqueIndex"`
	PasswordHash string
	Role         string
	Status       string
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
		Username:     user.Username,
		Email:        user.Email,
		PasswordHash: user.PasswordHash,
		Role:         string(user.Role),
		Status:       string(user.Status),
		CreatedAt:    user.CreatedAt.Unix(),
		UpdatedAt:    user.UpdatedAt.Unix(),
	}
}

// toEntity converts a UserModel to a User entity
func toEntity(model *UserModel) *entities.User {
	user, _ := entities.NewUser(
		model.ID,
		model.Username,
		model.Email,
		model.PasswordHash,
	)
	// Set fields that aren't set by NewUser
	user.Role = entities.UserRole(model.Role)
	user.Status = entities.UserStatus(model.Status)
	// Convert Unix timestamps to time.Time
	user.CreatedAt = time.Unix(model.CreatedAt, 0)
	user.UpdatedAt = time.Unix(model.UpdatedAt, 0)
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

// FindByUsername retrieves a user by username
func (r *GormUserRepository) FindByUsername(username string) (*entities.User, error) {
	var model UserModel
	if err := r.db.Where("username = ?", username).First(&model).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return toEntity(&model), nil
}

// FindAll retrieves all users
func (r *GormUserRepository) FindAll() ([]*entities.User, error) {
	var models []UserModel
	if err := r.db.Find(&models).Error; err != nil {
		return nil, err
	}

	users := make([]*entities.User, len(models))
	for i, model := range models {
		users[i] = toEntity(&model)
	}
	return users, nil
}

// FindWithFilter retrieves users matching the given filter
func (r *GormUserRepository) FindWithFilter(filter repositories.UserFilter) ([]*entities.User, error) {
	query := r.db.Model(&UserModel{})

	if filter.Username != "" {
		query = query.Where("username LIKE ?", "%"+filter.Username+"%")
	}
	if filter.Email != "" {
		query = query.Where("email LIKE ?", "%"+filter.Email+"%")
	}
	if filter.Role != "" {
		query = query.Where("role = ?", string(filter.Role))
	}
	if filter.Status != "" {
		query = query.Where("status = ?", string(filter.Status))
	}

	var models []UserModel
	if err := query.Find(&models).Error; err != nil {
		return nil, err
	}

	users := make([]*entities.User, len(models))
	for i, model := range models {
		users[i] = toEntity(&model)
	}
	return users, nil
}

// Delete removes a user from the repository
func (r *GormUserRepository) Delete(id string) error {
	return r.db.Delete(&UserModel{}, "id = ?", id).Error
}
