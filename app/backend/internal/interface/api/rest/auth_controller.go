package rest

import (
	"crypto/hmac"
	"crypto/sha256"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"github.com/labstack/echo/v4"
	"github.com/sklinkert/go-ddd/internal/application/services"
	"github.com/sklinkert/go-ddd/internal/config"
	"net/http"
	"strings"
	"time"
)

// AuthController handles authentication-related endpoints
type AuthController struct {
	userService *services.UserService
	jwtConfig   *config.JWTConfig
}

// NewAuthController creates a new AuthController and registers routes
func NewAuthController(e *echo.Echo, userService *services.UserService, jwtConfig *config.JWTConfig) {
	controller := &AuthController{
		userService: userService,
		jwtConfig:   jwtConfig,
	}

	// Public routes
	e.POST("/api/v1/register", controller.Register)
	e.POST("/api/v1/login", controller.Login)

	// Protected routes (require authentication)
	auth := e.Group("/api/v1/auth")
	auth.Use(controller.AuthMiddleware)
	auth.GET("/profile", controller.GetProfile)
}

// Register @Summary Register a new user
// @Description Register a new user with username, email and password
// @Tags auth
// @Accept json
// @Produce json
// @Param request body object{username=string,email=string,password=string} true "Registration details"
// @Success 201 {object} object{user=object{id=string,username=string,email=string,role=string,status=string},token=string}
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /register [post]
func (c *AuthController) Register(ctx echo.Context) error {
	var req struct {
		Username string `json:"username"`
		Email    string `json:"email"`
		Password string `json:"password"`
	}

	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request"})
	}

	// Validate input
	if req.Username == "" || req.Email == "" || req.Password == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "Username, email, and password are required"})
	}

	// Register user
	user, err := c.userService.RegisterUser(req.Username, req.Email, req.Password)
	if err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": err.Error()})
	}

	// Generate token
	token, err := c.generateToken(user.ID, user.Email)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to generate token"})
	}

	return ctx.JSON(http.StatusCreated, map[string]interface{}{
		"user": map[string]string{
			"id":       user.ID,
			"username": user.Username,
			"email":    user.Email,
			"role":     string(user.Role),
			"status":   string(user.Status),
		},
		"token": token,
	})
}

// Login @Summary User login
// @Description Authenticate a user with email and password
// @Tags auth
// @Accept json
// @Produce json
// @Param request body object{email=string,password=string} true "Login credentials"
// @Success 200 {object} object{user=object{id=string,username=string,email=string,role=string,status=string},token=string}
// @Failure 400 {object} map[string]string
// @Failure 401 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /login [post]
func (c *AuthController) Login(ctx echo.Context) error {
	var req struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}

	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request"})
	}

	// Authenticate user
	user, err := c.userService.Authenticate(req.Email, req.Password)
	if err != nil {
		return ctx.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid credentials"})
	}

	// Generate token
	token, err := c.generateToken(user.ID, user.Email)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to generate token"})
	}

	return ctx.JSON(http.StatusOK, map[string]interface{}{
		"user": map[string]string{
			"id":       user.ID,
			"username": user.Username,
			"email":    user.Email,
			"role":     string(user.Role),
			"status":   string(user.Status),
		},
		"token": token,
	})
}

// GetProfile @Summary Get user profile
// @Description Get the profile of the authenticated user
// @Tags auth
// @Accept json
// @Produce json
// @Security ApiKeyAuth
// @Success 200 {object} object{user=object{id=string,username=string,email=string,role=string,status=string}}
// @Failure 401 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /auth/profile [get]
func (c *AuthController) GetProfile(ctx echo.Context) error {
	// Get user ID from context (set by AuthMiddleware)
	userID := ctx.Get("userID").(string)

	// Get user from database
	userEntity, err := c.userService.GetUserByID(userID)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to get user"})
	}
	if userEntity == nil {
		return ctx.JSON(http.StatusNotFound, map[string]string{"error": "User not found"})
	}

	return ctx.JSON(http.StatusOK, map[string]interface{}{
		"user": map[string]string{
			"id":       userEntity.ID,
			"username": userEntity.Username,
			"email":    userEntity.Email,
			"role":     string(userEntity.Role),
			"status":   string(userEntity.Status),
		},
	})
}

// AuthMiddleware is a middleware that checks for a valid authentication token
// It expects a Bearer token in the Authorization header
// The token should be in the format "Bearer <token>"
// The token is validated using the validateToken method
// If the token is valid, the user ID and email are set in the context
// If the token is invalid, a 401 Unauthorized response is returned
func (c *AuthController) AuthMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(ctx echo.Context) error {
		// Get Authorization header
		authHeader := ctx.Request().Header.Get("Authorization")
		if authHeader == "" {
			return ctx.JSON(http.StatusUnauthorized, map[string]string{"error": "Authorization header is required"})
		}

		// Check if it starts with "Bearer "
		if !strings.HasPrefix(authHeader, "Bearer ") {
			return ctx.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid authorization format"})
		}

		// Extract token
		token := strings.TrimPrefix(authHeader, "Bearer ")

		// Validate token
		claims, err := c.validateToken(token)
		if err != nil {
			return ctx.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid token"})
		}

		// Set user ID in context
		ctx.Set("userID", claims["id"])
		ctx.Set("userEmail", claims["email"])

		return next(ctx)
	}
}

// generateToken generates a simple token for the given user
func (c *AuthController) generateToken(userID, email string) (string, error) {
	// Create claims
	claims := map[string]interface{}{
		"id":    userID,
		"email": email,
		"exp":   time.Now().Add(c.jwtConfig.TokenExpiry).Unix(),
	}

	// Convert claims to JSON
	claimsJSON, err := json.Marshal(claims)
	if err != nil {
		return "", err
	}

	// Base64 encode claims
	encodedClaims := base64.StdEncoding.EncodeToString(claimsJSON)

	// Create signature
	h := hmac.New(sha256.New, []byte(c.jwtConfig.SecretKey))
	h.Write([]byte(encodedClaims))
	signature := base64.StdEncoding.EncodeToString(h.Sum(nil))

	// Combine to create token
	token := fmt.Sprintf("%s.%s", encodedClaims, signature)

	return token, nil
}

// validateToken validates a token and returns the claims
func (c *AuthController) validateToken(token string) (map[string]interface{}, error) {
	// Split token into parts
	parts := strings.Split(token, ".")
	if len(parts) != 2 {
		return nil, fmt.Errorf("invalid token format")
	}

	encodedClaims := parts[0]
	signature := parts[1]

	// Verify signature
	h := hmac.New(sha256.New, []byte(c.jwtConfig.SecretKey))
	h.Write([]byte(encodedClaims))
	expectedSignature := base64.StdEncoding.EncodeToString(h.Sum(nil))

	if signature != expectedSignature {
		return nil, fmt.Errorf("invalid token signature")
	}

	// Decode claims
	claimsJSON, err := base64.StdEncoding.DecodeString(encodedClaims)
	if err != nil {
		return nil, err
	}

	// Parse claims
	var claims map[string]interface{}
	err = json.Unmarshal(claimsJSON, &claims)
	if err != nil {
		return nil, err
	}

	// Check expiration
	if exp, ok := claims["exp"].(float64); ok {
		if time.Now().Unix() > int64(exp) {
			return nil, fmt.Errorf("token expired")
		}
	}

	return claims, nil
}
