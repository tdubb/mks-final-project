Feature: Search for needs on C2G home page

  Scenario: Search for needs
    Given I am on the "home" page
    And There are needs
    When I search for "book"
    Then needs related to books are returned