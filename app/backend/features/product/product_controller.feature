Feature: Product Controller API
  In order to manage products through the API
  As a client
  I need to be able to create, read, update, and delete products via HTTP requests

  Scenario: Create a new product via API
    Given I have product details for API
      | name        | price | sellerId                             |
      | Test Product| 10.99 | 00000000-0000-0000-0000-000000000001 |
    When I send a POST request to "/api/v1/products" with the product details
    Then the response status code should be 201
    And the response should contain the created product details

  Scenario: Get all products via API
    Given there are products in the system
    When I send a GET request to "/api/v1/products"
    Then the response status code should be 200
    And the response should contain a list of products

  Scenario: Get a product by ID via API
    Given there is a product with ID "00000000-0000-0000-0000-000000000001" in the system
    When I send a GET request to "/api/v1/products/00000000-0000-0000-0000-000000000001"
    Then the response status code should be 200
    And the response should contain the product details