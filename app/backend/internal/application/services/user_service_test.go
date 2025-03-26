package services

import (
	"crypto/sha256"
	"encoding/hex"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"testing"
)

// MockUserRepository is a mock implementation of the UserRepository interface
type MockUserRepository struct {
	mock.Mock
}

func (m *MockUserRepository) Save(user *entities.User) error {
	args := m.Called(user)
	return args.Error(0)
}

func (m *MockUserRepository) FindByID(id string) (*entities.User, error) {
	args := m.Called(id)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*entities.User), args.Error(1)
}

func (m *MockUserRepository) FindByEmail(email string) (*entities.User, error) {
	args := m.Called(email)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*entities.User), args.Error(1)
}

func (m *MockUserRepository) Delete(id string) error {
	args := m.Called(id)
	return args.Error(0)
}

func TestUserService_RegisterUser(t *testing.T) {
	// Create a mock repository
	mockRepo := new(MockUserRepository)

	// Create a user service with the mock repository
	userService := NewUserService(mockRepo)

	// Test case: Register a new user
	t.Run("Register a new user", func(t *testing.T) {
		// Setup mock expectations
		mockRepo.On("FindByEmail", "test@example.com").Return(nil, nil)
		mockRepo.On("Save", mock.AnythingOfType("*entities.User")).Return(nil)

		// Call the method being tested
		user, err := userService.RegisterUser("test@example.com", "password123")

		// Assert expectations
		assert.NoError(t, err)
		assert.NotNil(t, user)
		assert.Equal(t, "test@example.com", user.Email)
		mockRepo.AssertExpectations(t)
	})

	// Test case: Register a user with an existing email
	t.Run("Register a user with an existing email", func(t *testing.T) {
		// Setup mock expectations
		existingUser, _ := entities.NewUser("user-id", "existing@example.com", "hashed-password")
		mockRepo.On("FindByEmail", "existing@example.com").Return(existingUser, nil)

		// Call the method being tested
		user, err := userService.RegisterUser("existing@example.com", "password123")

		// Assert expectations
		assert.Error(t, err)
		assert.Nil(t, user)
		assert.Contains(t, err.Error(), "already exists")
		mockRepo.AssertExpectations(t)
	})
}

func TestUserService_Authenticate(t *testing.T) {
	// Create a mock repository
	mockRepo := new(MockUserRepository)

	// Create a user service with the mock repository
	userService := NewUserService(mockRepo)

	// Create a test user with a known password
	testEmail := "test@example.com"
	testPassword := "password123"

	// Hash the password
	hasher := sha256.New()
	hasher.Write([]byte(testPassword))
	hashedPassword := hex.EncodeToString(hasher.Sum(nil))

	testUser, _ := entities.NewUser("user-id", testEmail, hashedPassword)

	// Test case: Authenticate with valid credentials
	t.Run("Authenticate with valid credentials", func(t *testing.T) {
		// Setup mock expectations
		mockRepo.On("FindByEmail", testEmail).Return(testUser, nil)

		// Call the method being tested
		user, err := userService.Authenticate(testEmail, testPassword)

		// Assert expectations
		assert.NoError(t, err)
		assert.NotNil(t, user)
		assert.Equal(t, testEmail, user.Email)
		mockRepo.AssertExpectations(t)
	})

	// Test case: Authenticate with invalid email
	t.Run("Authenticate with invalid email", func(t *testing.T) {
		// Setup mock expectations
		mockRepo.On("FindByEmail", "invalid@example.com").Return(nil, nil)

		// Call the method being tested
		user, err := userService.Authenticate("invalid@example.com", testPassword)

		// Assert expectations
		assert.Error(t, err)
		assert.Nil(t, user)
		assert.Contains(t, err.Error(), "not found")
		mockRepo.AssertExpectations(t)
	})

	// Test case: Authenticate with invalid password
	t.Run("Authenticate with invalid password", func(t *testing.T) {
		// Setup mock expectations
		mockRepo.On("FindByEmail", testEmail).Return(testUser, nil)

		// Call the method being tested
		user, err := userService.Authenticate(testEmail, "wrong-password")

		// Assert expectations
		assert.Error(t, err)
		assert.Nil(t, user)
		assert.Contains(t, err.Error(), "invalid password")
		mockRepo.AssertExpectations(t)
	})
}
