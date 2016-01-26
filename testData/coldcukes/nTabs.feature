Feature: Output N number of Tabs
	Convenience method to add tabs to a string
	Scenario: The system needs 1 tab
	    Given the object has the nTabs method
	    When I call request 1 tab
	    Then 1 tab is returned
    
	Scenario: The system needs 4 tabs
	    Given the object has the nTabs method
	    When I call request 4 tabs
	    Then 4 tabs are returned