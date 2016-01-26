Feature: Write the beginning of a TestBox CFC

  Scenario: The object can write the beginning of a TestBox CFC
    Given the object has a writeTestBoxCFCBegin() method
    When I call the writeTestBoxCFCBegin() method
    Then the proper CFC code is returned