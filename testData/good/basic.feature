Feature: Detect if an object has a Merchant
    Lookup by Sales Team Number if there's an associated Merchant
        Scenario: System requests the Merchant
            Given the Sales Team Number is 1
                When I request if there's a Merchant
                Then it should return false.
            Given the Sales Team Number is not passed in
                When I request if there's a Merchant
                Then it should return an exception.
            Given the Sales Team Number is 2 (via Mock)
                When I request if there's a Merchant
                Then it should return false.