package entities

import (
	"errors"
	"time"
)

// UserRole represents the role of a user in the system
type UserRole string

const (
	// RoleAdmin is the role for administrators
	RoleAdmin UserRole = "admin"
	// RoleUser is the role for regular users
	RoleUser UserRole = "user"
)

// UserStatus represents the status of a user in the system
type UserStatus string

const (
	// StatusActive indicates an active user
	StatusActive UserStatus = "active"
	// StatusInactive indicates an inactive user
	StatusInactive UserStatus = "inactive"
	// StatusLocked indicates a locked user
	StatusLocked UserStatus = "locked"
)

// User represents a user in the system
type User struct {
	ID           string
	Username     string
	Email        string
	PasswordHash string
	Role         UserRole
	Status       UserStatus
	CreatedAt    time.Time
	UpdatedAt    time.Time
}

// NewUser creates a new user with the given ID, username, email, and password hash
func NewUser(id, username, email, passwordHash string) (*User, error) {
	if id == "" {
		return nil, errors.New("user ID cannot be empty")
	}
	if username == "" {
		return nil, errors.New("username cannot be empty")
	}
	if email == "" {
		return nil, errors.New("email cannot be empty")
	}
	if passwordHash == "" {
		return nil, errors.New("password hash cannot be empty")
	}

	now := time.Now()
	return &User{
		ID:           id,
		Username:     username,
		Email:        email,
		PasswordHash: passwordHash,
		Role:         RoleUser,
		Status:       StatusActive,
		CreatedAt:    now,
		UpdatedAt:    now,
	}, nil
}

// UpdateUsername updates the user's username
func (u *User) UpdateUsername(username string) error {
	if username == "" {
		return errors.New("username cannot be empty")
	}
	u.Username = username
	u.UpdatedAt = time.Now()
	return nil
}

// UpdateEmail updates the user's email
func (u *User) UpdateEmail(email string) error {
	if email == "" {
		return errors.New("email cannot be empty")
	}
	u.Email = email
	u.UpdatedAt = time.Now()
	return nil
}

// UpdatePassword updates the user's password hash
func (u *User) UpdatePassword(passwordHash string) error {
	if passwordHash == "" {
		return errors.New("password hash cannot be empty")
	}
	u.PasswordHash = passwordHash
	u.UpdatedAt = time.Now()
	return nil
}

// UpdateRole updates the user's role
func (u *User) UpdateRole(role UserRole) error {
	u.Role = role
	u.UpdatedAt = time.Now()
	return nil
}

// UpdateStatus updates the user's status
func (u *User) UpdateStatus(status UserStatus) error {
	u.Status = status
	u.UpdatedAt = time.Now()
	return nil
}
