component extends="testbox.system.BaseSpec"{

function beforeAll(){
	// you may want to initialize the object you are testing here
}

function run(){

	Feature( "Detect if an object has a Merchant", function(){
		describe( "Lookup by Sales Team Number if there's an associated Merchant", function(){
			Scenario( "System requests the Merchant", function(){
				Given( "the Sales Team Number is 1", function(){
					When( "I request if there's a Merchant", function(){
						Then( "it should return false.", function(){
							// test code below
							fail('test not implemented yet');
						});
	When( "I request if there's a Merchant", function(){
						Then( "it should return an exception.", function(){
							// test code below
							fail('test not implemented yet');
						});
	When( "I request if there's a Merchant", function(){
						Then( "it should return false.", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
					});
					});
				});
				Given( "the Sales Team Number is not passed in", function(){
				[[replace_here]]
				});
				Given( "the Sales Team Number is 2 (via Mock)", function(){
				[[replace_here]]
				});
			});
		});
	});

	Feature( "Validating a Date Range (250 ms)", function(){
		describe( "In order to ensure good data in the system two dates for a date range must be validated (249 ms)", function(){
			Scenario( "User enters two valid dates of consecutive days (2 ms)", function(){
				Given( "there are two fields available for dates (2 ms)", function(){
					When( "I enter a valid date for the first date, and I enter a valid date for the second date, and the second date is the day after the first (1 ms)", function(){
						Then( "it should be a valid date range. (0 ms)", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
			Scenario( "User enters two valid dates of exactly one year apart (5 ms)", function(){
				Given( "there are two fields available for dates (5 ms)", function(){
					When( "I enter a valid date for the first date, and I enter a valid date for the second date, and the second date is exactly one year after the first (2 ms)", function(){
						Then( "it should be a valid date range. (1 ms)", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
			Scenario( "User enters two valid dates but the second date is before the first (4 ms)", function(){
				Given( "there are two fields available for dates (3 ms)", function(){
					When( "I enter a valid date for the first date, and I enter a valid date for the second date, but the second date is the day before the first (3 ms)", function(){
						Then( "it should NOT be a valid date range. (2 ms)", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
			Scenario( "User enters two valid dates but the second date is the same as the first (26 ms)", function(){
				Given( "there are two fields available for dates (26 ms)", function(){
					When( "I enter a valid date for the first date, and I enter a valid date for the second date, but the second date is the same as the first (25 ms)", function(){
						Then( "it should be a valid date range. (25 ms)", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
			Scenario( "User enters two valid dates in mm/dd/yyyy format (2 ms)", function(){
				Given( "there are two fields available for dates (2 ms)", function(){
					When( "I enter a valid date for the first date, and I enter a valid date for the second date, and both dates are in mm/dd/yyyy format and the second date is one month after the first (2 ms)", function(){
						Then( "it should be a valid date range. (1 ms)", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
			Scenario( "User enters two valid dates but the second date is in the wrong format (210 ms)", function(){
				Given( "there are two fields available for dates (210 ms)", function(){
					When( "I enter a valid date for the first date, and I enter a valid date for the second date, but the second date is not in the specified format (209 ms)", function(){
						Then( "it should NOT be a valid date range. (2 ms)", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
		});
	});

	Feature( "my feature 1", function(){
		describe( "desc of feature 1", function(){
			Scenario( "my scenario 1a", function(){
				Given( "precondition 1a 1", function(){
					When( "criteria 1a 1", function(){
					When( "criteria 1a 2", function(){
						When( "criteria 1a 2", function(){
						Then( "result 1a 1", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
					});
					});
				});
			});
			Scenario( "my scenario 1b", function(){
				Given( "precondition 1b 1", function(){
					When( "criteria 1b 1", function(){
						Then( "result 1b 1", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
		});
	});

	Feature( "Minimal", function(){
			Scenario( "minimalistic", function(){
				Given( "the minimalism", function(){
				[[replace_here]]
				});
			});
	});

} //end run()

} //end component