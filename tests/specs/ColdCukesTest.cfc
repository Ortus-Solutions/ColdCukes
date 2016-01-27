component extends="testbox.system.BaseSpec"{

function beforeAll(){
	// you may want to initialize the object you are testing here
	obj = new ColdCukes.ColdCukes();
	obj.setLineBreakCharacters( chr(13) & chr(10) );
	obj.setTabCharacters( chr(9) );
}

function run(){


	Feature( "Initialize ColdCukes object", function(){
			Scenario( "The system invokes the object", function(){
				Given( "the object has an init() method", function(){
					When( "I call the init() method", function(){
						Then( "the object is initialized", function(){
							// test code below
							new ColdCukes.ColdCukes();

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
							obj.setFeaturesDirectory( "/testData/coldcukes/" );
						});
					});
				});
			});
			Scenario( "The system Gets the directory", function(){
				Given( "the object has a Get directory method", function(){
					When( "I call the Get directory method", function(){
						Then( "the directory is returned", function(){
							// test code below
							local.dir = obj.getFeaturesDirectory();
							expect( local.dir ).toBe( "/testData/coldcukes/" );

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
							obj.setTabCharacters( chr(9) );
						});
					});
				});
			});
			Scenario( "The system Gets the Tab Characters", function(){
				Given( "the object has a Get Tab Characters method", function(){
					When( "I call the Get Tab Characters method", function(){
						Then( "the Tab is returned", function(){
							// test code below
							expect( obj.getTabCharacters() ).toBe( chr(9) );

						});
					});
				});
			});
	});
	
	
	Feature( "output N number of Tabs", function(){
			Scenario( "The system needs 1 tab", function(){
				Given( "the object has the nTabs method", function(){
					When( "I call request 1 tab", function(){
						Then( "1 tab is returned", function(){
							// test code below
							expect( obj.nTabs(1) ).toBe( chr(9) );

						});
					});
				});
			});
			Scenario( "The system needs 4 tabs", function(){
				Given( "the object has the nTabs method", function(){
					When( "I call request 4 tabs", function(){
						Then( "4 tabs are returned", function(){
							// test code below
							expect( obj.nTabs(4) ).toBe( chr(9)&chr(9)&chr(9)&chr(9) );

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
							obj.setLineBreakCharacters( chr(13) & chr(10) );

						});
					});
				});
			});
			Scenario( "The system Gets the Line Break Characters", function(){
				Given( "the object has a Get Line Break Characters method", function(){
					When( "I call the Get Line Break Characters method", function(){
						Then( "the break is returned", function(){
							// test code below
							expect( obj.getLineBreakCharacters() ).toBe( chr(13) & chr(10) );

						});
					});
				});
			});
	});
	
	
	Feature( "output N number of Line Breaks", function(){
			Scenario( "The system needs 1 Line Break", function(){
				Given( "the object has the nBreaks method", function(){
					When( "I request 1 break", function(){
						Then( "1 break is returned", function(){
							// test code below
							expect( obj.nBreaks(1) ).toBe( chr(13) & chr(10) );

						});
					});
				});
			});
			Scenario( "The system needs 3 Line Breaks", function(){
				Given( "the object has the nBreaks method", function(){
					When( "I request 3 Line Breaks", function(){
						Then( "3 Breaks are returned", function(){
							// test code below
							expect( obj.nBreaks(3) ).toBe( chr(13) & chr(10)&chr(13) & chr(10)&chr(13) & chr(10) );

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
							expect( obj.writeTestBoxCFCBegin() )
								.toInclude('component extends="testbox.system.BaseSpec"{')
								.toInclude('function beforeAll(){')
								.toInclude('function run(){')
							;

						});
					});
				});
			});
	});
	
	
	Feature( "Write the end of a TestBox CFC", function(){
			Scenario( "The object can write the ending of a TestBox CFC", function(){
				Given( "the object has a writeTestBoxCFCEnd() method", function(){
					When( "I call the writeTestBoxCFCEnd() method", function(){
						Then( "the proper CFC code is returned", function(){
							// test code below
							expect( obj.writeTestBoxCFCEnd() )
								.toInclude('} //end run()')
								.toInclude('} //end component')
							;

						});
					});
				});
			});
	});


} //end run()

} //end component