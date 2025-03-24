package postgres

import (
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// NewConnection returns a new GORM v2 database connection
func NewConnection() (*gorm.DB, error) {
	dsn := "host=localhost user=root password=password dbname=postgres port=5432 sslmode=disable TimeZone=Asia/Tokyo"
	return gorm.Open(postgres.Open(dsn), &gorm.Config{})
}
