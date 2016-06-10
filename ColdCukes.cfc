component
{

	// reasonable default instance values
	instance.TabCharacters = chr(9);
	instance.LineBreakCharacters = chr(13) & chr(10);

	// constructor
	public ColdCukes function init(
        AstBuilderObj = createObject("Java", "gherkin.AstBuilder"),
        GherkinParser = createObject("Java", "gherkin.Parser")
    ) 
	{
		// the Gherkin JAR files must be in the CF lib directory; this sets up our parser for gherkin Features files
    	instance.parserObj = GherkinParser.init( AstBuilderObj.init() );
		return this;
	}

	// directory where feature files are stored
	public void function setFeaturesDirectory(required string dir)
	{
		instance.FeaturesDirectory = arguments.dir;
	}

	public string function getFeaturesDirectory()
	{
		return instance.FeaturesDirectory;
	}

	// directory where BDD Test stub files are created
	public void function setOutputDirectory(required string dir)
	{
		instance.OutputDirectory = arguments.dir;
	}

	public string function getOutputDirectory()
	{
		return instance.OutputDirectory;
	}

	// tab or spaces characters, depending on your code preferences
	public void function setTabCharacters(required string tab)
	{
		instance.TabCharacters = arguments.tab;
	}

	public string function getTabCharacters()
	{
		return instance.TabCharacters;
	}

	// line break characters, depending on your code preferences
	public void function setLineBreakCharacters(required string crlf)
	{
		instance.LineBreakCharacters = arguments.crlf;
	}

	public string function getLineBreakCharacters()
	{
		return instance.LineBreakCharacters;
	}

	// get N number of tabs
	public string function nTabs(required numeric num)
	{
		return RepeatString( getTabCharacters(), arguments.num );
	}

	// get N number of breaks
	public string function nBreaks(required numeric num)
	{
		return RepeatString( getLineBreakCharacters(), arguments.num );
	}

	// begin TestBox CFC
	public string function writeTestBoxCFCBegin()
	{
		var str = '';
		str &= 'component extends="testbox.system.BaseSpec"{' & nBreaks(2);
		str &= 'function beforeAll(){' & nBreaks(1);
		str &= nTabs(1) & '// you may want to initialize the object you are testing here' & nBreaks(1);
		str &= '}' & nBreaks(2);
		str &= 'function run(){' & nBreaks(2);

		return str;
	}

	// end TestBox CFC
	public string function writeTestBoxCFCEnd()
	{
		var str = '';
		str &= '} //end run()' & nBreaks(2);
    	str &= '} //end component';

		return str;
	}

	// begin Feature
	public string function writeFeatureBegin(required any feature)
	{
		var str = '';
		str &= nTabs(1) & arguments.feature.getKeyword();
	    str &= '( "#arguments.feature.getName()#", function(){' & nBreaks(1);

	    if ( Len(arguments.feature.getDescription()) ){
	    	str &= nTabs(2) & 'describe( "#arguments.feature.getDescription().trim()#", function(){' & nBreaks(1);
	    }

		return str;
	}

	// end Feature
	public string function writeFeatureEnd(required any feature)
	{
		var str = '';
		if ( Len(arguments.feature.getDescription()) ){
	    	str &= nTabs(2) & '});' & nBreaks(1);
	    }
	    str &= nTabs(1) & '});' & nBreaks(2);

		return str;
	}

	// begin Scenario
	public string function writeScenarioBegin(required any Scenario)
	{
		var str = '';
		str &= nTabs(3) & arguments.scenario.getKeyword();
        str &= '( "#arguments.scenario.getName()#", function(){' & nBreaks(1);

		return str;
	}

	// end Scenario
	public string function writeScenarioEnd()
	{
		var str = nTabs(3) & '});' & nBreaks(1);

		return str;
	}

	// step string
	public string function writeSteps( required any steps )
	{
		var stepsString = "";

		var i = 0;
		for (var step in arguments.steps) {
			// iterate the steps
			i++;

			var keyword = step.getKeyword().trim();

			var whenString = "";
	        var thenString = "";

	        // Given should be first, and we make a placeholder because TestBox Given-When-Then format is nested
	        if (keyword EQ "Given") {

	            stepsString &= nTabs(4);
	            stepsString &= keyword;
	            stepsString &= '( "#step.getText()#", function(){' & nBreaks(1);
	            stepsString &= nTabs(4) & "[[replace_here]]" & nBreaks(1);
	            stepsString &= nTabs(4);
	            stepsString &= '});' & nBreaks(1);

	            // loop from next step on until the step keyword is NOT Given or And
				for (var j=i+1;j LTE ArrayLen(arguments.steps);j++) {
					var nextStep = arguments.steps[j];
	            	var nextStepKeyword = nextStep.getKeyword().trim();

				 	if (ListFindNoCase("and,given", nextStepKeyword)) {
				 		// WriteOutput(nextStepKeyword & ": " & nextStep.getText() & "<br>");

				 		var subStepsString = '';
			            subStepsString &= 'Given';
			            subStepsString &= '( "#nextStep.getText()#", function(){' & nBreaks(1);
			            subStepsString &= nTabs(4) & "[[replace_here]]" & nBreaks(1);
			            subStepsString &= nTabs(4);
			            subStepsString &= '});';

			            stepsString = Replace(stepsString, "[[replace_here]]", subStepsString);

			 		} else {
				 		break;
				 	}
				}

	        }

	        if (keyword EQ "When") {

	            whenString &= nTabs(1);
	            whenString &= keyword;
	            whenString &= '( "#step.getText()#", function(){' & nBreaks(1);
	            whenString &= nTabs(5) & "[[replace_here]]" & nBreaks(1);
	            whenString &= nTabs(5);
	            whenString &= '});';

	            // replace the string set in the GIVEN section with the WHEN block we just created
	            stepsString = Replace(stepsString, "[[replace_here]]", whenString);

	            for (var k=i+1;j LTE ArrayLen(arguments.steps);k++) {
					var nextStep = arguments.steps[k];
	            	var nextStepKeyword = nextStep.getKeyword().trim();

				 	if (ListFindNoCase("and,when", nextStepKeyword)) {

				 		var subWhenString = '';
			            subWhenString &= 'When';
			            subWhenString &= '( "#nextStep.getText()#", function(){' & nBreaks(1);
			            subWhenString &= nTabs(5) & "[[replace_here]]" & nBreaks(1);
			            subWhenString &= nTabs(5);
			            subWhenString &= '});';

			            stepsString = Replace(stepsString, "[[replace_here]]", subWhenString);

			 		} else {
				 		break;
				 	}
				}

	        }

	        if (keyword EQ "Then") {

	            thenString &= nTabs(1);
	            thenString &= keyword;
	            thenString &= '( "#step.getText()#", function(){' & nBreaks(1);
	            thenString &= nTabs(7) & "// test code below" & nBreaks(1);
	            thenString &= nTabs(7) & "fail('test not implemented yet');" & nBreaks(1);
	            thenString &= nTabs(6);
	            thenString &= '});';

				// add this only if we are NOT on the last step
	            if (i LT ArrayLen(arguments.steps)) {
	            	thenString &= nBreaks(1) & "[[replace_here]]";
	            }

	            // replace the string set in the WHEN section with the THEN block we just created
	            stepsString = Replace(stepsString, "[[replace_here]]", thenString);

	            //writedump(ArrayLen(arguments.steps));abort;

	            for (var n=i+1;j LTE ArrayLen(arguments.steps);n++) {

					if (n GT ArrayLen(arguments.steps)) {
						break;
					} else {

						var nextStep = arguments.steps[n];
		            	var nextStepKeyword = nextStep.getKeyword().trim();

					 	if (ListFindNoCase("and,then", nextStepKeyword)) {

					 		var subThenString = '';

				            subThenString &= nTabs(6) & 'Then';
				            subThenString &= '( "#nextStep.getText()#", function(){' & nBreaks(1);
				            subThenString &= nTabs(7) & "// test code below" & nBreaks(1);
				            subThenString &= nTabs(7) & "fail('test not implemented yet');" & nBreaks(1);
				            subThenString &= nTabs(6);
				            subThenString &= '});';

				            stepsString = Replace(stepsString, "[[replace_here]]", subThenString);

				 		} else {
					 		break;
					 	}

				 	}
				}
	        }

        }

        return stepsString;
	}

	// list the Feature files
	public array function listFeatureFiles()
	{
		return DirectoryList( getFeaturesDirectory() );
	}

	// this is the workhorse that creates the Gherkin-style BDD testbox files based on the static feature files
	public string function generateGherkinTests()
	{
		var strBegin = writeTestBoxCFCBegin();
		var strEnd = writeTestBoxCFCEnd();

		var featureFiles = listFeatureFiles();

		// BEGIN features loop
		for (var featureFile in featureFiles) {

			// break out of the loop if it's not a feature file
			if (listLast(featureFile,".") NEQ "feature") {
				continue;
			}

			// grab the feature file and use the Java objects to parse it
			var fileText = fileRead(featureFile);
			var feature = instance.parserObj.parse( fileText );

			var featureStrBegin = writeFeatureBegin( feature );
			var featureStrEnd = writeFeatureEnd( feature );

		    // grab the array of scenarios
    		var scenarios = feature.getScenarioDefinitions();

    		// BEGIN scenarios loop
		    for (var scenario in scenarios) {

		    	var scenarioStrBegin = writeScenarioBegin( scenario );
		    	var scenarioStrEnd = writeScenarioEnd();

		    	// get the steps (Given, When, Then) to loop over
        		var steps = scenario.getSteps();

        		var stepsStr = writeSteps( steps );

        		// add the Steps to the parent string
        		scenarioStrBegin &= stepsStr;

		    	// add the Scenarios to the parent string
        		featureStrBegin &= scenarioStrBegin & scenarioStrEnd;

		    // END scenarios loop
		    }

		    // add the features to the parent string
		    strBegin &= featureStrBegin & featureStrEnd;

		// END features loop
		}

		var fileContents = strBegin & strEnd;

		// use this to debug
		//writeOutput('<textarea cols="130" rows="55">#fileContents#</textarea>');abort;

		// create the output directory if it doesn't exist
		if ( !DirectoryExists(getOutputDirectory()) ) {
			DirectoryCreate(getOutputDirectory());
		}

		var outputFile = writeTestBoxFile(fileContents);

		// return the output file for convenience
		return outputFile;
	}


	public string function writeTestBoxFile(required string fileContents)
	{
		// set the file name dynamically
		var filePathAndName = getOutputDirectory() & ListLast(getFeaturesDirectory(), "/\") & "Test.cfc";
    	fileWrite(filePathAndName, arguments.fileContents);

    	return filePathAndName;
	}

}
