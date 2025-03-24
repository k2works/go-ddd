# language: ja
フィーチャ: Product Controller API
  In order to manage products through the API
  As a client
  I need to be able to create, read, update, and delete products via HTTP requests

  シナリオ: Create a new product via API
    前提 I have product details for API
      | name        | price | sellerId                             |
      | Test Product| 10.99 | 00000000-0000-0000-0000-000000000001 |
    もし I send a POST request to "/api/v1/products" with the product details
    ならば the response status code should be 201
    かつ the response should contain the created product details

  シナリオ: Get all products via API
    前提 there are products in the system
    もし I send a GET request to "/api/v1/products"
    ならば the response status code should be 200
    かつ the response should contain a list of products

  シナリオ: Get a product by ID via API
    前提 there is a product with ID "00000000-0000-0000-0000-000000000001" in the system
    もし I send a GET request to "/api/v1/products/00000000-0000-0000-0000-000000000001"
    ならば the response status code should be 200
    かつ the response should contain the product details
