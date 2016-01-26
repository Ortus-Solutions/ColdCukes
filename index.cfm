<cfscript>
	/*
	start here to make changes to how the stub files are generated
	*/

	// this is where your *.feature files (Gherkin formatted text) should live
    parseDirectory = expandPath(".") & "/testData/";
    
    // grab just the ones we want to loop over, as an array
    arrDirectories = DirectoryList(parseDirectory, false, "array", "coldcukes*", "directory ASC");
    
    outputDir = expandPath(".") & '/tests/stubs/';
    
    // clear the directory so we have fresh files and delete out ones where the matching Gherkin feature file was deleted
	DirectoryDelete( outputDir, true );

    // loop through the directories and create TestBox Gherkin style BDD test file stubs 
    for (featureDir in arrDirectories) {
    	
    	// start using the ColdCukes obj for parsing
	    obj = new testbox.generator.ColdCukes();
		obj.setFeaturesDirectory( featureDir );
		obj.setOutputDirectory( outputDir );
		
		// optionally pass in different break or tab characters for the outputted code
		//obj.setLineBreakCharacters( chr(13) & chr(10) );
		//obj.setTabCharacters( chr(9) );
		
		// run it and see the file that was returned, which is auto-generated (including the dir) if not there already
		outputFile = obj.generateGherkinTests();
		
		// you should be able to run the resulting files via TestBox with no errors
		writeoutput("generated Gherkin tests in '#outputFile#' successfully!<br>");
	
	}
	
</cfscript>