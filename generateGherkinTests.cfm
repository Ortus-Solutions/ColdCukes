<!---
  use this file to hack around and figure out how it all works
--->

<cfscript>

    // the Gherkin JAR files must be in the CF lib directory; this sets up our parser for gherkin Features files
    //AstBuilderObj = createObject("Java", "gherkin.AstBuilder");
    //parserObj = createObject("Java", "gherkin.Parser").init( AstBuilderObj.init() );
    
    parseDirectory = expandPath(".") & "/testData/";
    
    // grab just the ones we want to loop over, as an array
    arrDirectory = DirectoryList(parseDirectory, false, "array", "coldcukes*", "directory ASC");
    
    
    //writeDump(arrDirectory);
    //abort;
    
    //fileToParse = parseDirectory & "writeTestBoxCFCBegin.feature";
    
    //fileText = fileRead(fileToParse);

    /*
    parse a file or text here
    */
    //feature = parserObj.parse( fileText );

    // set some string variables to build up the output
    returnStringBegin = "";
    returnStringEnd = "";
    crlf = chr(13) & chr(10);
    tab = chr(9);
    
    for (dir in arrDirectory) {
    	
    	// start using the CC obj for parsing
	    obj = new ColdCukes();
		obj.setFeaturesDirectory( dir );
		obj.setOutputDirectory( expandPath('/tests/stubs/') );
		//obj.setLineBreakCharacters( crlf );
		//obj.setTabCharacters( tab );
		
		outputFile = obj.generateGherkinTests();
		
		writeoutput("generated Gherkin tests in '#outputFile#' successfully!<br>");
	
	}
    
    abort;

/*
    writeDump(feature);
    writeDump(feature.getKeyword());
    writeDump(feature.getName());
    writeDump(feature.getDescription());
*/

	// begin test component
	/*
	returnStringBegin &= 'component extends="testbox.system.BaseSpec"{' & crlf & crlf;
	returnStringBegin &= 'function beforeAll(){' & crlf;
	returnStringBegin &= tab & '// you may want to initialize the object you are testing here' & crlf;
	returnStringBegin &= '}' & crlf & crlf;
	
	returnStringBegin &= 'function run(){' & crlf & crlf;
	*/
	returnStringBegin &= obj.writeTestBoxCFCBegin();
	
	// TODO: begin looping over the feature files here

    // the beginning output of the BDD test
    returnStringBegin &= tab & feature.getKeyword();
    returnStringBegin &= '( "#feature.getName()#", function(){' & crlf;
    
    if ( Len(feature.getDescription()) ){
    	returnStringBegin &= tab & tab & 'describe( "#feature.getDescription().trim()#", function(){' & crlf;
    }

    // grab the array of scenarios
    scenarios = feature.getScenarioDefinitions();

    for (scenario in scenarios) {

        scenarioStringBegin = "";
        scenarioStringEnd = "";

        scenarioStringBegin &= tab & tab & tab & scenario.getKeyword();
        scenarioStringBegin &= '( "#scenario.getName()#", function(){' & crlf;

        stepsString = "";

        // get the steps (Given, When, Then) to loop over
        steps = scenario.getSteps();

        for (step in steps) {

            keyword = step.getKeyword().trim();

            whenString = "";
            thenString = "";

            // Given should be first, and we make a placeholder because TestBox Given-When-Then format is nested
            if (keyword EQ "Given") {

                stepsString &= tab & tab & tab & tab;

                stepsString &= keyword;
                stepsString &= '( "#step.getText()#", function(){' & crlf;

                stepsString &= tab & tab & tab & tab & "[[When_here]]" & crlf;

                stepsString &= tab & tab & tab & tab;

                stepsString &= '});' & crlf;

            }

            if (keyword EQ "When") {

                whenString &= tab;

                whenString &= keyword;
                whenString &= '( "#step.getText()#", function(){' & crlf;

                whenString &= tab & tab & tab & tab & tab & "[[Then_here]]" & crlf;

                whenString &= tab & tab & tab & tab & tab;

                whenString &= '});';

                stepsString = Replace(stepsString, "[[When_here]]", whenString);
            }

            if (keyword EQ "Then") {

                thenString &= tab;

                thenString &= keyword;
                thenString &= '( "#step.getText()#", function(){' & crlf;

                thenString &= tab & tab & tab & tab & tab & tab & tab & "// test code below" & crlf & crlf;

                thenString &= tab & tab & tab & tab & tab & tab;

                thenString &= '});';

                stepsString = Replace(stepsString, "[[Then_here]]", thenString);
            }

        }

        // add the Steps to the larger string
        scenarioStringBegin &= stepsString;

        // end of each scenario
        scenarioStringEnd &= tab & tab & tab & '});' & crlf;

        // add the Scenarios to the larger string
        returnStringBegin &= scenarioStringBegin & scenarioStringEnd;
    }

    // end of the feature
    if ( Len(feature.getDescription()) ){
    	returnStringEnd &= tab & tab & '});' & crlf;
    }
    returnStringEnd &= tab & '});' & crlf & crlf;
    
    // end CFC wrapper
    returnStringEnd &= obj.writeTestBoxCFCEnd();
    
    returnFileContents = Trim(returnStringBegin & returnStringEnd);

    writeOutput('<textarea cols="130" rows="55">#returnFileContents#</textarea>');
    
    outputFile = expandPath('/tests/specs') & "/ColdCukesTest2.cfc";
    fileWrite(outputFile, returnFileContents);

    /*
    scenario1a = feature.getScenarioDefinitions()[1];

    writeDump(scenario1a);
    writeDump(scenario1a.getKeyword());
    writeDump(scenario1a.getName());
    writeDump(scenario1a.getSteps());

    scenario1a_step1 = scenario1a.getSteps()[1];
    //writeDump(scenario1a_step1);
    writeDump(scenario1a_step1.getKeyword());
    writeDump(scenario1a_step1.getText());

    scenario1a_step2 = scenario1a.getSteps()[2];
    writeDump(scenario1a_step2.getKeyword());
    writeDump(scenario1a_step2.getText());

    */

</cfscript>
