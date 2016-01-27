component extends="testbox.system.BaseSpec"{

function beforeAll(){
	// you may want to initialize the object you are testing here
}

function run(){

	Feature( "Initialize ColdCukes object", function(){
			Scenario( "The system invokes the object", function(){
				Given( "the object has an init() method", function(){
					When( "I call the init() method", function(){
						Then( "the object is initialized", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
	});

	Feature( "Output N number of Tabs", function(){
		describe( "Convenience method to add tabs to a string", function(){
			Scenario( "The system needs 1 tab", function(){
				Given( "the object has the nTabs method", function(){
					When( "I call request 1 tab", function(){
						Then( "1 tab is returned", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
			Scenario( "The system needs 4 tabs", function(){
				Given( "the object has the nTabs method", function(){
					When( "I call request 4 tabs", function(){
						Then( "4 tabs are returned", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
		});
	});

} //end run()

} //end component