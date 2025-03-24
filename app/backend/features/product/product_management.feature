Feature: Product Management
  In order to manage products in the system
  As a user
  I need to be able to create, read, update, and delete products

  Scenario: Create a new product
    Given I have product details
      | name        | price |
      | Test Product| 10.99 |
    And I have a seller
    When I create a new product
    Then the product should be saved in the system
    And I should be able to retrieve the product by ID

  Scenario: Update an existing product
    Given I have an existing product
    When I update the product details
      | name           | price |
      | Updated Product| 15.99 |
    Then the product details should be updated in the system

  Scenario: Delete a product
    Given I have an existing product
    When I delete the product
    Then the product should be removed from the system
