package repositories

import (
	"github.com/sklinkert/go-ddd/internal/domain/entities"
)

// UserFilter defines filters for querying users
type UserFilter struct {
	Username string
	Email    string
	Role     entities.UserRole
	Status   entities.UserStatus
}

// UserRepository defines the interface for user persistence operations
type UserRepository interface {
	// Save persists a user to the repository
	Save(user *entities.User) error

	// FindByID retrieves a user by ID
	FindByID(id string) (*entities.User, error)

	// FindByEmail retrieves a user by email
	FindByEmail(email string) (*entities.User, error)

	// FindByUsername retrieves a user by username
	FindByUsername(username string) (*entities.User, error)

	// FindAll retrieves all users
	FindAll() ([]*entities.User, error)

	// FindWithFilter retrieves users matching the given filter
	FindWithFilter(filter UserFilter) ([]*entities.User, error)

	// Delete removes a user from the repository
	Delete(id string) error
}
