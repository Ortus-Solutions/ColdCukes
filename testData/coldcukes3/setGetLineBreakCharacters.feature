Feature: set and get the Line Break Characters 

	Scenario: The system sets the Line Break Characters
	    Given the object has a set Line Break Characters method
	    When I call the set Line Break Characters method
	    Then the break is set
    
	Scenario: The system Gets the Line Break Characters
	    Given the object has a Get Line Break Characters method
	    When I call the Get Line Break Characters method
	    Then the break is returned