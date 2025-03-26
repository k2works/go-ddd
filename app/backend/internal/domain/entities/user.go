package entities

import (
	"errors"
	"time"
)

// User represents a user in the system
type User struct {
	ID           string
	Email        string
	PasswordHash string
	CreatedAt    time.Time
	UpdatedAt    time.Time
}

// NewUser creates a new user with the given ID, email, and password hash
func NewUser(id, email, passwordHash string) (*User, error) {
	if id == "" {
		return nil, errors.New("user ID cannot be empty")
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
		Email:        email,
		PasswordHash: passwordHash,
		CreatedAt:    now,
		UpdatedAt:    now,
	}, nil
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