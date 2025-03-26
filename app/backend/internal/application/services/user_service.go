package services

import (
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"github.com/google/uuid"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"github.com/sklinkert/go-ddd/internal/domain/repositories"
)

// UserService handles user-related operations
type UserService struct {
	userRepository repositories.UserRepository
}

// NewUserService creates a new UserService
func NewUserService(userRepository repositories.UserRepository) *UserService {
	return &UserService{
		userRepository: userRepository,
	}
}

// RegisterUser registers a new user
func (s *UserService) RegisterUser(email, password string) (*entities.User, error) {
	// Check if user already exists
	existingUser, err := s.userRepository.FindByEmail(email)
	if err != nil {
		return nil, err
	}
	if existingUser != nil {
		return nil, errors.New("user with this email already exists")
	}

	// Hash the password
	hasher := sha256.New()
	hasher.Write([]byte(password))
	hashedPassword := hex.EncodeToString(hasher.Sum(nil))

	// Create a new user
	user, err := entities.NewUser(
		uuid.New().String(),
		email,
		string(hashedPassword),
	)
	if err != nil {
		return nil, err
	}

	// Save the user
	err = s.userRepository.Save(user)
	if err != nil {
		return nil, err
	}

	return user, nil
}

// Authenticate authenticates a user with email and password
func (s *UserService) Authenticate(email, password string) (*entities.User, error) {
	// Find the user by email
	user, err := s.userRepository.FindByEmail(email)
	if err != nil {
		return nil, err
	}
	if user == nil {
		return nil, errors.New("user not found")
	}

	// Verify the password
	hasher := sha256.New()
	hasher.Write([]byte(password))
	hashedPassword := hex.EncodeToString(hasher.Sum(nil))

	if user.PasswordHash != hashedPassword {
		return nil, errors.New("invalid password")
	}

	return user, nil
}

// GetUserByID retrieves a user by ID
func (s *UserService) GetUserByID(id string) (*entities.User, error) {
	return s.userRepository.FindByID(id)
}

// GetUserByEmail retrieves a user by email
func (s *UserService) GetUserByEmail(email string) (*entities.User, error) {
	return s.userRepository.FindByEmail(email)
}

// UpdateUserEmail updates a user's email
func (s *UserService) UpdateUserEmail(id, email string) error {
	user, err := s.userRepository.FindByID(id)
	if err != nil {
		return err
	}
	if user == nil {
		return errors.New("user not found")
	}

	err = user.UpdateEmail(email)
	if err != nil {
		return err
	}

	return s.userRepository.Save(user)
}

// UpdateUserPassword updates a user's password
func (s *UserService) UpdateUserPassword(id, password string) error {
	user, err := s.userRepository.FindByID(id)
	if err != nil {
		return err
	}
	if user == nil {
		return errors.New("user not found")
	}

	// Hash the new password
	hasher := sha256.New()
	hasher.Write([]byte(password))
	hashedPassword := hex.EncodeToString(hasher.Sum(nil))

	err = user.UpdatePassword(string(hashedPassword))
	if err != nil {
		return err
	}

	return s.userRepository.Save(user)
}

// DeleteUser deletes a user
func (s *UserService) DeleteUser(id string) error {
	return s.userRepository.Delete(id)
}
