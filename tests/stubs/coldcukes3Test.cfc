component extends="testbox.system.BaseSpec"{

function beforeAll(){
	// you may want to initialize the object you are testing here
}

function run(){

	Feature( "set and get the Features File Directory", function(){
			Scenario( "The system sets the directory", function(){
				Given( "the object has a set directory method", function(){
					When( "I call the set directory method", function(){
						Then( "the directory is set", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
			Scenario( "The system Gets the directory", function(){
				Given( "the object has a Get directory method", function(){
					When( "I call the Get directory method", function(){
						Then( "the directory is returned", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
	});

	Feature( "set and get the Line Break Characters", function(){
			Scenario( "The system sets the Line Break Characters", function(){
				Given( "the object has a set Line Break Characters method", function(){
					When( "I call the set Line Break Characters method", function(){
						Then( "the break is set", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
			Scenario( "The system Gets the Line Break Characters", function(){
				Given( "the object has a Get Line Break Characters method", function(){
					When( "I call the Get Line Break Characters method", function(){
						Then( "the break is returned", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
	});

	Feature( "set and get the Tab Characters", function(){
			Scenario( "The system sets the Tab Characters", function(){
				Given( "the object has a set Tab Characters method", function(){
					When( "I call the set Tab Characters method", function(){
						Then( "the Tab is set", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
			Scenario( "The system Gets the Tab Characters", function(){
				Given( "the object has a Get Tab Characters method", function(){
					When( "I call the Get Tab Characters method", function(){
						Then( "the Tab is returned", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
	});

	Feature( "Write the beginning of a TestBox CFC", function(){
			Scenario( "The object can write the beginning of a TestBox CFC", function(){
				Given( "the object has a writeTestBoxCFCBegin() method", function(){
					When( "I call the writeTestBoxCFCBegin() method", function(){
						Then( "the proper CFC code is returned", function(){
							// test code below
							fail('test not implemented yet');
						});
					});
				});
			});
	});

} //end run()

} //end component