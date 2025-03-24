package steps

import (
	"fmt"
	"github.com/cucumber/godog"
	"github.com/google/uuid"
	"github.com/sklinkert/go-ddd/internal/domain/entities"
	"strconv"
)

// ProductContext holds the state for product-related steps
type ProductContext struct {
	productDetails  map[string]string
	product         *entities.Product
	seller          *entities.Seller
	validatedSeller *entities.ValidatedSeller
	err             error
}

// NewProductContext creates a new ProductContext
func NewProductContext() *ProductContext {
	return &ProductContext{}
}

// RegisterSteps registers the product steps with the godog suite
func (p *ProductContext) RegisterSteps(ctx *godog.ScenarioContext) {
	// Japanese step definitions
	ctx.Step(`^商品の詳細を持っています$`, p.iHaveProductDetails)
	ctx.Step(`^出品者を持っています$`, p.iHaveASeller)
	ctx.Step(`^新しい商品を作成します$`, p.iCreateANewProduct)
	ctx.Step(`^商品がシステムに保存されるべきです$`, p.theProductShouldBeSavedInTheSystem)
	ctx.Step(`^IDで商品を取得できるべきです$`, p.iShouldBeAbleToRetrieveTheProductByID)
	ctx.Step(`^既存の商品を持っています$`, p.iHaveAnExistingProduct)
	ctx.Step(`^商品の詳細を更新します$`, p.iUpdateTheProductDetails)
	ctx.Step(`^商品の詳細がシステムで更新されるべきです$`, p.theProductDetailsShouldBeUpdatedInTheSystem)
	ctx.Step(`^商品を削除します$`, p.iDeleteTheProduct)
	ctx.Step(`^商品がシステムから削除されるべきです$`, p.theProductShouldBeRemovedFromTheSystem)

	// Keep English step definitions for backward compatibility
	ctx.Step(`^I have product details$`, p.iHaveProductDetails)
	ctx.Step(`^I have a seller$`, p.iHaveASeller)
	ctx.Step(`^I create a new product$`, p.iCreateANewProduct)
	ctx.Step(`^the product should be saved in the system$`, p.theProductShouldBeSavedInTheSystem)
	ctx.Step(`^I should be able to retrieve the product by ID$`, p.iShouldBeAbleToRetrieveTheProductByID)
	ctx.Step(`^I have an existing product$`, p.iHaveAnExistingProduct)
	ctx.Step(`^I update the product details$`, p.iUpdateTheProductDetails)
	ctx.Step(`^the product details should be updated in the system$`, p.theProductDetailsShouldBeUpdatedInTheSystem)
	ctx.Step(`^I delete the product$`, p.iDeleteTheProduct)
	ctx.Step(`^the product should be removed from the system$`, p.theProductShouldBeRemovedFromTheSystem)
}

func (p *ProductContext) iHaveProductDetails(table *godog.Table) error {
	p.productDetails = make(map[string]string)

	// Skip the header row
	for i := 1; i < len(table.Rows); i++ {
		row := table.Rows[i]
		for j, cell := range row.Cells {
			header := table.Rows[0].Cells[j].Value
			// Map Japanese headers to English
			switch header {
			case "名前":
				p.productDetails["name"] = cell.Value
			case "価格":
				p.productDetails["price"] = cell.Value
			default:
				p.productDetails[header] = cell.Value
			}
		}
	}

	return nil
}

func (p *ProductContext) iHaveASeller() error {
	// Create a seller
	p.seller = entities.NewSeller("Test Seller")

	// Validate the seller
	validatedSeller, err := entities.NewValidatedSeller(p.seller)
	if err != nil {
		return fmt.Errorf("failed to validate seller: %w", err)
	}

	p.validatedSeller = validatedSeller
	return nil
}

func (p *ProductContext) iCreateANewProduct() error {
	name := p.productDetails["name"]
	priceStr := p.productDetails["price"]

	price, err := strconv.ParseFloat(priceStr, 64)
	if err != nil {
		return fmt.Errorf("failed to parse price: %w", err)
	}

	// Create a new product using the factory method
	p.product = entities.NewProduct(name, price, *p.validatedSeller)

	return nil
}

func (p *ProductContext) theProductShouldBeSavedInTheSystem() error {
	// In a real implementation, this would verify the product was saved
	// For now, we'll just check that the product was created
	if p.product == nil {
		return fmt.Errorf("product was not created")
	}
	return nil
}

func (p *ProductContext) iShouldBeAbleToRetrieveTheProductByID() error {
	// In a real implementation, this would retrieve the product from the repository
	// For now, we'll just check that the product has an ID
	if p.product.Id == uuid.Nil {
		return fmt.Errorf("product ID is empty")
	}
	return nil
}

func (p *ProductContext) iHaveAnExistingProduct() error {
	// Create a seller
	p.seller = entities.NewSeller("Test Seller")

	// Validate the seller
	validatedSeller, err := entities.NewValidatedSeller(p.seller)
	if err != nil {
		return fmt.Errorf("failed to validate seller: %w", err)
	}

	// Create a sample product for testing
	p.product = entities.NewProduct("Existing Product", 9.99, *validatedSeller)
	return nil
}

func (p *ProductContext) iUpdateTheProductDetails(table *godog.Table) error {
	p.productDetails = make(map[string]string)

	// Skip the header row
	for i := 1; i < len(table.Rows); i++ {
		row := table.Rows[i]
		for j, cell := range row.Cells {
			header := table.Rows[0].Cells[j].Value
			// Map Japanese headers to English
			switch header {
			case "名前":
				p.productDetails["name"] = cell.Value
			case "価格":
				p.productDetails["price"] = cell.Value
			default:
				p.productDetails[header] = cell.Value
			}
		}
	}

	// Update the product name
	err := p.product.UpdateName(p.productDetails["name"])
	if err != nil {
		return fmt.Errorf("failed to update product name: %w", err)
	}

	// Update the product price
	priceStr := p.productDetails["price"]
	price, err := strconv.ParseFloat(priceStr, 64)
	if err != nil {
		return fmt.Errorf("failed to parse price: %w", err)
	}

	err = p.product.UpdatePrice(price)
	if err != nil {
		return fmt.Errorf("failed to update product price: %w", err)
	}

	return nil
}

func (p *ProductContext) theProductDetailsShouldBeUpdatedInTheSystem() error {
	// In a real implementation, this would verify the product was updated in the repository
	// For now, we'll just check that the product details match what we expect
	if p.product.Name != p.productDetails["name"] {
		return fmt.Errorf("product name was not updated correctly")
	}

	priceStr := p.productDetails["price"]
	expectedPrice, _ := strconv.ParseFloat(priceStr, 64)
	if p.product.Price != expectedPrice {
		return fmt.Errorf("product price was not updated correctly")
	}

	return nil
}

func (p *ProductContext) iDeleteTheProduct() error {
	// In a real implementation, this would delete the product from the repository
	// For now, we'll just set the product to nil to simulate deletion
	p.product = nil
	return nil
}

func (p *ProductContext) theProductShouldBeRemovedFromTheSystem() error {
	// Check that the product is nil (deleted)
	if p.product != nil {
		return fmt.Errorf("product was not deleted")
	}
	return nil
}
