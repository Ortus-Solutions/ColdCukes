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

</cfscript>
