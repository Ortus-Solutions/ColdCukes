Feature: set and get the Features File Directory

	Scenario: The system sets the directory
	    Given the object has a set directory method
	    When I call the set directory method
	    Then the directory is set
    
	Scenario: The system Gets the directory
	    Given the object has a Get directory method
	    When I call the Get directory method
	    Then the directory is returned