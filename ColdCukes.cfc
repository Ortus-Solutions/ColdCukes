component 
{
	
	// reasonable default instance values
	instance.TabCharacters = chr(9);
	instance.LineBreakCharacters = chr(13) & chr(10);
	
	// constructor
	public ColdCukes function init() output="false"
	{
		
		// the Gherkin JAR files must be in the CF lib directory; this sets up our parser for gherkin Features files
		AstBuilderObj = createObject("Java", "gherkin.AstBuilder");
    	instance.parserObj = createObject("Java", "gherkin.Parser").init( AstBuilderObj.init() );
		
		return this;
	}
	
	// directory where feature files are stored
	public void function setFeaturesDirectory(required string dir) output="false"
	{
		instance.FeaturesDirectory = arguments.dir;
	}

	public string function getFeaturesDirectory() output="false"
	{
		return instance.FeaturesDirectory;
	}   
	
	// directory where BDD Test stub files are created
	public void function setOutputDirectory(required string dir) output="false"
	{
		instance.OutputDirectory = arguments.dir;
	}

	public string function getOutputDirectory() output="false"
	{
		return instance.OutputDirectory;
	}
	
	// tab or spaces characters, depending on your code preferences
	public void function setTabCharacters(required string tab) output="false"
	{
		instance.TabCharacters = arguments.tab;
	}

	public string function getTabCharacters() output="false"
	{
		return instance.TabCharacters;
	}
	
	// line break characters, depending on your code preferences
	public void function setLineBreakCharacters(required string crlf) output="false"
	{
		instance.LineBreakCharacters = arguments.crlf;
	}

	public string function getLineBreakCharacters() output="false"
	{
		return instance.LineBreakCharacters;
	}
	
	// get N number of tabs
	public string function nTabs(required numeric num) output="false" 
	{
		return RepeatString( getTabCharacters(), arguments.num );
	}  
	
	// get N number of breaks
	public string function nBreaks(required numeric num) output="false" 
	{
		return RepeatString( getLineBreakCharacters(), arguments.num );
	}
	
	// begin TestBox CFC
	public string function writeTestBoxCFCBegin() output="false" 
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
	public string function writeTestBoxCFCEnd() output="false" 
	{
		var str = '';
		str &= '} //end run()' & nBreaks(2);
    	str &= '} //end component';
		
		return str;
	}
	
	// begin Feature
	public string function writeFeatureBegin(required any feature) output="false" 
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
	public string function writeFeatureEnd(required any feature) output="false" 
	{
		var str = '';
		if ( Len(arguments.feature.getDescription()) ){
	    	str &= nTabs(2) & '});' & nBreaks(1);
	    }
	    str &= nTabs(1) & '});' & nBreaks(2);
		
		return str;
	}
	
	// begin Scenario
	public string function writeScenarioBegin(required any Scenario) output="false" 
	{
		var str = '';
		str &= nTabs(3) & arguments.scenario.getKeyword();
        str &= '( "#arguments.scenario.getName()#", function(){' & nBreaks(1);
		
		return str;
	}
	
	// end Scenario
	public string function writeScenarioEnd() output="false" 
	{
		var str = nTabs(3) & '});' & nBreaks(1);
		
		return str;
	}
	
	// step string
	public string function writeSteps( required any steps ) output="false" 
	{	
		var stepsString = "";
		
		// TODO: add support for the AND steps keywords
		
		for (var step in arguments.steps) {
			
			var keyword = step.getKeyword().trim();	
			
			var whenString = "";
	        var thenString = "";
	
	        // Given should be first, and we make a placeholder because TestBox Given-When-Then format is nested
	        if (keyword EQ "Given") {
	
	            stepsString &= nTabs(4);
	            stepsString &= keyword;
	            stepsString &= '( "#step.getText()#", function(){' & nBreaks(1);
	            stepsString &= nTabs(4) & "[[When_here]]" & nBreaks(1);
	            stepsString &= nTabs(4);
	            stepsString &= '});' & nBreaks(1);
	
	        }
	
	        if (keyword EQ "When") {
	
	            whenString &= nTabs(1);
	            whenString &= keyword;
	            whenString &= '( "#step.getText()#", function(){' & nBreaks(1);
	            whenString &= nTabs(5) & "[[Then_here]]" & nBreaks(1);
	            whenString &= nTabs(5);
	            whenString &= '});';
	
				// replace the string set in the GIVEN section with the WHEN block we just created
	            stepsString = Replace(stepsString, "[[When_here]]", whenString);
	        }
	
	        if (keyword EQ "Then") {
	
	            thenString &= nTabs(1);
	            thenString &= keyword;
	            thenString &= '( "#step.getText()#", function(){' & nBreaks(1);
	            thenString &= nTabs(7) & "// test code below" & nBreaks(1);
	            thenString &= nTabs(7) & "fail('test not implemented yet');" & nBreaks(1);
	            thenString &= nTabs(6);
	            thenString &= '});';
	
	            // replace the string set in the WHEN section with the THEN block we just created
	            stepsString = Replace(stepsString, "[[Then_here]]", thenString);
	        }
        
        }
        
        return stepsString;
	}
	
	// list the Feature files
	public array function listFeatureFiles() output="false" 
	{
		return DirectoryList( getFeaturesDirectory() );
	}  
	
	// this is the workhorse that creates the Gherkin-style BDD testbox files based on the static feature files
	public string function generateGherkinTests() output="false"
	{
		var strBegin = writeTestBoxCFCBegin();
		var strEnd = writeTestBoxCFCEnd();
		
		var featureFiles = listFeatureFiles();
		
		// BEGIN features loop
		for (var featureFile in featureFiles) {
			
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
	
	
	public string function writeTestBoxFile(required string fileContents) output="false"
	{
		// set the file name dynamically
		var filePathAndName = getOutputDirectory() & ListLast(getFeaturesDirectory(), "/\") & "Test.cfc";
    	fileWrite(filePathAndName, arguments.fileContents);
    	
    	return filePathAndName;
	}

}