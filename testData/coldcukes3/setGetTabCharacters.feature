Feature: set and get the Tab Characters 

	Scenario: The system sets the Tab Characters
	    Given the object has a set Tab Characters method
	    When I call the set Tab Characters method
	    Then the Tab is set
    
	Scenario: The system Gets the Tab Characters
	    Given the object has a Get Tab Characters method
	    When I call the Get Tab Characters method
	    Then the Tab is returned