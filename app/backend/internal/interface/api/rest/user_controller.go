package rest

import (
	"github.com/labstack/echo/v4"
	"github.com/sklinkert/go-ddd/internal/application/services"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"github.com/sklinkert/go-ddd/internal/domain/repositories"
	"net/http"
)

// UserController handles user management endpoints
type UserController struct {
	userService *services.UserService
}

// NewUserController creates a new UserController and registers routes
func NewUserController(e *echo.Echo, userService *services.UserService) {
	controller := &UserController{
		userService: userService,
	}

	// Protected routes (require authentication)
	users := e.Group("/api/v1/users")
	users.Use(controller.AdminMiddleware)
	users.GET("", controller.ListUsers)
	users.GET("/:id", controller.GetUser)
	users.POST("", controller.CreateUser)
	users.PUT("/:id", controller.UpdateUser)
	users.DELETE("/:id", controller.DeleteUser)
	users.PUT("/:id/role", controller.UpdateUserRole)
	users.PUT("/:id/status", controller.UpdateUserStatus)
}

// AdminMiddleware is a middleware that checks if the user has admin role
func (c *UserController) AdminMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(ctx echo.Context) error {
		// Get user ID from context (set by AuthMiddleware)
		userID, ok := ctx.Get("userID").(string)
		if !ok {
			return ctx.JSON(http.StatusUnauthorized, map[string]string{"error": "Not authenticated"})
		}

		// Get user from database
		user, err := c.userService.GetUserByID(userID)
		if err != nil {
			return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to get user"})
		}
		if user == nil {
			return ctx.JSON(http.StatusUnauthorized, map[string]string{"error": "User not found"})
		}

		// Check if user has admin role
		if user.Role != entities.RoleAdmin {
			return ctx.JSON(http.StatusForbidden, map[string]string{"error": "Admin role required"})
		}

		return next(ctx)
	}
}

// ListUsers @Summary List users
// @Description List all users or filter by criteria
// @Tags users
// @Accept json
// @Produce json
// @Param username query string false "Filter by username"
// @Param email query string false "Filter by email"
// @Param role query string false "Filter by role"
// @Param status query string false "Filter by status"
// @Success 200 {array} object{id=string,username=string,email=string,role=string,status=string}
// @Failure 401 {object} map[string]string
// @Failure 403 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /users [get]
func (c *UserController) ListUsers(ctx echo.Context) error {
	// Get filter parameters
	filter := repositories.UserFilter{
		Username: ctx.QueryParam("username"),
		Email:    ctx.QueryParam("email"),
		Role:     entities.UserRole(ctx.QueryParam("role")),
		Status:   entities.UserStatus(ctx.QueryParam("status")),
	}

	// Get users
	var users []*entities.User
	var err error
	if filter.Username != "" || filter.Email != "" || filter.Role != "" || filter.Status != "" {
		users, err = c.userService.FindUsers(filter)
	} else {
		users, err = c.userService.GetAllUsers()
	}

	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to get users"})
	}

	// Convert to response format
	response := make([]map[string]string, len(users))
	for i, user := range users {
		response[i] = map[string]string{
			"id":       user.ID,
			"username": user.Username,
			"email":    user.Email,
			"role":     string(user.Role),
			"status":   string(user.Status),
		}
	}

	return ctx.JSON(http.StatusOK, response)
}

// GetUser @Summary Get user
// @Description Get a user by ID
// @Tags users
// @Accept json
// @Produce json
// @Param id path string true "User ID"
// @Success 200 {object} object{id=string,username=string,email=string,role=string,status=string}
// @Failure 401 {object} map[string]string
// @Failure 403 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /users/{id} [get]
func (c *UserController) GetUser(ctx echo.Context) error {
	id := ctx.Param("id")
	if id == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "User ID is required"})
	}

	user, err := c.userService.GetUserByID(id)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to get user"})
	}
	if user == nil {
		return ctx.JSON(http.StatusNotFound, map[string]string{"error": "User not found"})
	}

	return ctx.JSON(http.StatusOK, map[string]string{
		"id":       user.ID,
		"username": user.Username,
		"email":    user.Email,
		"role":     string(user.Role),
		"status":   string(user.Status),
	})
}

// CreateUser @Summary Create user
// @Description Create a new user
// @Tags users
// @Accept json
// @Produce json
// @Param user body object{username=string,email=string,password=string,role=string,status=string} true "User details"
// @Success 201 {object} object{id=string,username=string,email=string,role=string,status=string}
// @Failure 400 {object} map[string]string
// @Failure 401 {object} map[string]string
// @Failure 403 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /users [post]
func (c *UserController) CreateUser(ctx echo.Context) error {
	var req struct {
		Username string `json:"username"`
		Email    string `json:"email"`
		Password string `json:"password"`
		Role     string `json:"role"`
		Status   string `json:"status"`
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

	// Update role and status if provided
	if req.Role != "" {
		err = c.userService.UpdateUserRole(user.ID, entities.UserRole(req.Role))
		if err != nil {
			return ctx.JSON(http.StatusBadRequest, map[string]string{"error": err.Error()})
		}
	}

	if req.Status != "" {
		err = c.userService.UpdateUserStatus(user.ID, entities.UserStatus(req.Status))
		if err != nil {
			return ctx.JSON(http.StatusBadRequest, map[string]string{"error": err.Error()})
		}
	}

	// Get updated user
	user, err = c.userService.GetUserByID(user.ID)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to get user"})
	}

	return ctx.JSON(http.StatusCreated, map[string]string{
		"id":       user.ID,
		"username": user.Username,
		"email":    user.Email,
		"role":     string(user.Role),
		"status":   string(user.Status),
	})
}

// UpdateUser @Summary Update user
// @Description Update a user
// @Tags users
// @Accept json
// @Produce json
// @Param id path string true "User ID"
// @Param user body object{username=string,email=string,password=string} true "User details"
// @Success 200 {object} object{id=string,username=string,email=string,role=string,status=string}
// @Failure 400 {object} map[string]string
// @Failure 401 {object} map[string]string
// @Failure 403 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /users/{id} [put]
func (c *UserController) UpdateUser(ctx echo.Context) error {
	id := ctx.Param("id")
	if id == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "User ID is required"})
	}

	var req struct {
		Username string `json:"username"`
		Email    string `json:"email"`
		Password string `json:"password"`
	}

	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request"})
	}

	// Update username if provided
	if req.Username != "" {
		err := c.userService.UpdateUserUsername(id, req.Username)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest, map[string]string{"error": err.Error()})
		}
	}

	// Update email if provided
	if req.Email != "" {
		err := c.userService.UpdateUserEmail(id, req.Email)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest, map[string]string{"error": err.Error()})
		}
	}

	// Update password if provided
	if req.Password != "" {
		err := c.userService.UpdateUserPassword(id, req.Password)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest, map[string]string{"error": err.Error()})
		}
	}

	// Get updated user
	user, err := c.userService.GetUserByID(id)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to get user"})
	}
	if user == nil {
		return ctx.JSON(http.StatusNotFound, map[string]string{"error": "User not found"})
	}

	return ctx.JSON(http.StatusOK, map[string]string{
		"id":       user.ID,
		"username": user.Username,
		"email":    user.Email,
		"role":     string(user.Role),
		"status":   string(user.Status),
	})
}

// UpdateUserRole @Summary Update user role
// @Description Update a user's role
// @Tags users
// @Accept json
// @Produce json
// @Param id path string true "User ID"
// @Param role body object{role=string} true "User role"
// @Success 200 {object} object{id=string,username=string,email=string,role=string,status=string}
// @Failure 400 {object} map[string]string
// @Failure 401 {object} map[string]string
// @Failure 403 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /users/{id}/role [put]
func (c *UserController) UpdateUserRole(ctx echo.Context) error {
	id := ctx.Param("id")
	if id == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "User ID is required"})
	}

	var req struct {
		Role string `json:"role"`
	}

	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request"})
	}

	if req.Role == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "Role is required"})
	}

	err := c.userService.UpdateUserRole(id, entities.UserRole(req.Role))
	if err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": err.Error()})
	}

	// Get updated user
	user, err := c.userService.GetUserByID(id)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to get user"})
	}
	if user == nil {
		return ctx.JSON(http.StatusNotFound, map[string]string{"error": "User not found"})
	}

	return ctx.JSON(http.StatusOK, map[string]string{
		"id":       user.ID,
		"username": user.Username,
		"email":    user.Email,
		"role":     string(user.Role),
		"status":   string(user.Status),
	})
}

// UpdateUserStatus @Summary Update user status
// @Description Update a user's status
// @Tags users
// @Accept json
// @Produce json
// @Param id path string true "User ID"
// @Param status body object{status=string} true "User status"
// @Success 200 {object} object{id=string,username=string,email=string,role=string,status=string}
// @Failure 400 {object} map[string]string
// @Failure 401 {object} map[string]string
// @Failure 403 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /users/{id}/status [put]
func (c *UserController) UpdateUserStatus(ctx echo.Context) error {
	id := ctx.Param("id")
	if id == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "User ID is required"})
	}

	var req struct {
		Status string `json:"status"`
	}

	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request"})
	}

	if req.Status == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "Status is required"})
	}

	err := c.userService.UpdateUserStatus(id, entities.UserStatus(req.Status))
	if err != nil {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": err.Error()})
	}

	// Get updated user
	user, err := c.userService.GetUserByID(id)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to get user"})
	}
	if user == nil {
		return ctx.JSON(http.StatusNotFound, map[string]string{"error": "User not found"})
	}

	return ctx.JSON(http.StatusOK, map[string]string{
		"id":       user.ID,
		"username": user.Username,
		"email":    user.Email,
		"role":     string(user.Role),
		"status":   string(user.Status),
	})
}

// DeleteUser @Summary Delete user
// @Description Delete a user
// @Tags users
// @Accept json
// @Produce json
// @Param id path string true "User ID"
// @Success 204 "No Content"
// @Failure 400 {object} map[string]string
// @Failure 401 {object} map[string]string
// @Failure 403 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /users/{id} [delete]
func (c *UserController) DeleteUser(ctx echo.Context) error {
	id := ctx.Param("id")
	if id == "" {
		return ctx.JSON(http.StatusBadRequest, map[string]string{"error": "User ID is required"})
	}

	err := c.userService.DeleteUser(id)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to delete user"})
	}

	return ctx.NoContent(http.StatusNoContent)
}
