// @title Marketplace API
// @version 1.0
// @description This is a marketplace API server.
// @host localhost:9090
// @BasePath /api/v1
package main

import (
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"github.com/labstack/echo/v4"
	_ "github.com/sklinkert/go-ddd/docs" // Swaggerドキュメントのインポート
	"github.com/sklinkert/go-ddd/internal/application/services"
	postgres2 "github.com/sklinkert/go-ddd/internal/infrastructure/db/postgres"
	"github.com/sklinkert/go-ddd/internal/interface/api/rest"
	echoSwagger "github.com/swaggo/echo-swagger"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"log"
)

func main() {
	dsn := "host=localhost user=root password=password dbname=mydb port=5432 sslmode=disable TimeZone=Asia/Shanghai"
	port := ":9090"

	gormDB, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	err = gormDB.AutoMigrate()
	if err != nil {
		log.Fatalf("Failed to migrate database: %v", err)
	}

	productRepo := postgres2.NewGormProductRepository(gormDB)
	sellerRepo := postgres2.NewGormSellerRepository(gormDB)

	productService := services.NewProductService(productRepo, sellerRepo)
	sellerService := services.NewSellerService(sellerRepo)

	e := echo.New()
	// Swagger UIのエンドポイントを設定
	e.GET("/swagger/*", echoSwagger.WrapHandler)

	rest.NewProductController(e, productService)
	rest.NewSellerController(e, sellerService)

	if err := e.Start(port); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
