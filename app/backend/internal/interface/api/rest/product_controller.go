package rest

import (
	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/sklinkert/go-ddd/internal/application/interfaces"
	"github.com/sklinkert/go-ddd/internal/interface/api/rest/dto/mapper"
	"github.com/sklinkert/go-ddd/internal/interface/api/rest/dto/request"
	"net/http"
)

type ProductController struct {
	service interfaces.ProductService
}

func NewProductController(e *echo.Echo, service interfaces.ProductService) *ProductController {
	controller := &ProductController{
		service: service,
	}

	e.POST("/api/v1/products", controller.CreateProductController)
	e.GET("/api/v1/products", controller.GetAllProductsController)
	e.GET("/api/v1/products/:id", controller.GetProductByIdController)
	e.Use(middleware.Recover())

	return controller
}

// CreateProductController @Summary Create a new product
// @Description Create a new product with the provided details
// @Tags products
// @Accept json
// @Produce json
// @Success 201 {object} response.ProductResponse
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /products [post]
func (pc *ProductController) CreateProductController(c echo.Context) error {
	var createProductRequest request.CreateProductRequest

	if err := c.Bind(&createProductRequest); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{
			"error": "Failed to parse request body",
		})
	}

	productCommand, err := createProductRequest.ToCreateProductCommand()
	if err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{
			"error": "Invalid product Id format",
		})
	}

	result, err := pc.service.CreateProduct(productCommand)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"error": "Failed to create product",
		})
	}

	response := mapper.ToProductResponse(result.Result)

	return c.JSON(http.StatusCreated, response)
}

// GetAllProductsController @Summary Get all products
// @Description Get a list of all products
// @Tags products
// @Accept json
// @Produce json
// @Success 200 {array} response.ProductResponse
// @Failure 500 {object} map[string]string
// @Router /products [get]
func (pc *ProductController) GetAllProductsController(c echo.Context) error {
	products, err := pc.service.FindAllProducts()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"error": "Failed to fetch products",
		})
	}

	response := mapper.ToProductListResponse(products.Result)

	return c.JSON(http.StatusOK, response)
}

// GetProductByIdController @Summary Get a product by ID
// @Description Get a product by its ID
// @Tags products
// @Accept json
// @Produce json
// @Param id path string true "Product ID"
// @Success 200 {object} response.ProductResponse
// @Failure 400 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /products/{id} [get]
func (pc *ProductController) GetProductByIdController(c echo.Context) error {
	id, err := uuid.Parse(c.Param("id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{
			"error": "Invalid product Id format",
		})
	}

	product, err := pc.service.FindProductById(id)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"error": "Failed to fetch product",
		})
	}

	if product == nil {
		return c.JSON(http.StatusNotFound, map[string]string{
			"error": "Product not found",
		})
	}

	response := mapper.ToProductResponse(product.Result)

	return c.JSON(http.StatusOK, response)
}
