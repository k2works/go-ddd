package main

import (
	"github.com/sklinkert/go-ddd/internal/infrastructure/db/postgres"
	"gorm.io/gen"
)

func main() {
	g := gen.NewGenerator(gen.Config{
		OutPath:           "./internal/infrastructure/db/postgres/gen/query", // Output path
		Mode:              gen.WithoutContext | gen.WithDefaultQuery | gen.WithQueryInterface,
		FieldWithIndexTag: true,
		FieldWithTypeTag:  true,
		FieldNullable:     true,
	})

	// Get database connection
	db, err := postgres.NewConnection()
	if err != nil {
		panic(err)
	}

	g.UseDB(db)

	// Generate all tables
	all := g.GenerateAllTable()

	g.ApplyBasic(all...)

	// Generate the code
	g.Execute()
}
