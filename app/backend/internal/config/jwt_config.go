package config

import (
	"time"
)

// JWTConfig contains configuration for JWT authentication
type JWTConfig struct {
	SecretKey     string
	TokenExpiry   time.Duration
	SigningMethod string
}

// NewJWTConfig creates a new JWT configuration with default values
func NewJWTConfig() *JWTConfig {
	return &JWTConfig{
		SecretKey:     "your-secret-key", // In production, this should be loaded from environment variables
		TokenExpiry:   24 * time.Hour,    // 24 hours
		SigningMethod: "HS256",           // HMAC with SHA-256
	}
}
