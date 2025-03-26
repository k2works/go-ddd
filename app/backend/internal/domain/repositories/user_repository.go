package repositories

import (
	"github.com/sklinkert/go-ddd/internal/domain/entities"
)

// UserRepository defines the interface for user persistence operations
type UserRepository interface {
	// Save persists a user to the repository
	Save(user *entities.User) error

	// FindByID retrieves a user by ID
	FindByID(id string) (*entities.User, error)

	// FindByEmail retrieves a user by email
	FindByEmail(email string) (*entities.User, error)

	// Delete removes a user from the repository
	Delete(id string) error
}