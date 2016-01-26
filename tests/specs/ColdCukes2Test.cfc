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

						});
					});
				});
			});
			Scenario( "The system needs 4 tabs", function(){
				Given( "the object has the nTabs method", function(){
					When( "I call request 4 tabs", function(){
						Then( "4 tabs are returned", function(){
							// test code below

						});
					});
				});
			});
		});
	});

	Feature( "set and get the Features File Directory", function(){
			Scenario( "The system sets the directory", function(){
				Given( "the object has a set directory method", function(){
					When( "I call the set directory method", function(){
						Then( "the directory is set", function(){
							// test code below

						});
					});
				});
			});
			Scenario( "The system Gets the directory", function(){
				Given( "the object has a Get directory method", function(){
					When( "I call the Get directory method", function(){
						Then( "the directory is returned", function(){
							// test code below

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

						});
					});
				});
			});
			Scenario( "The system Gets the Line Break Characters", function(){
				Given( "the object has a Get Line Break Characters method", function(){
					When( "I call the Get Line Break Characters method", function(){
						Then( "the break is returned", function(){
							// test code below

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

						});
					});
				});
			});
			Scenario( "The system Gets the Tab Characters", function(){
				Given( "the object has a Get Tab Characters method", function(){
					When( "I call the Get Tab Characters method", function(){
						Then( "the Tab is returned", function(){
							// test code below

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

						});
					});
				});
			});
	});

} //end run()

} //end component