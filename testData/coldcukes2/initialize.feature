Feature: Initialize ColdCukes object

  Scenario: The system invokes the object
    Given the object has an init() method
    When I call the init() method
    Then the object is initialized