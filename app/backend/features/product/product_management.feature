# language: ja
フィーチャ: Product Management
  In order to manage products in the system
  As a user
  I need to be able to create, read, update, and delete products

  シナリオ: Create a new product
    前提 I have product details
      | name        | price |
      | Test Product| 10.99 |
    かつ I have a seller
    もし I create a new product
    ならば the product should be saved in the system
    かつ I should be able to retrieve the product by ID

  シナリオ: Update an existing product
    前提 I have an existing product
    もし I update the product details
      | name           | price |
      | Updated Product| 15.99 |
    ならば the product details should be updated in the system

  シナリオ: Delete a product
    前提 I have an existing product
    もし I delete the product
    ならば the product should be removed from the system
