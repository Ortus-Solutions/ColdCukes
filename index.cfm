<cfscript>

	/*
	start here to make changes to how the stub files are generated
	*/
	
	// this is where your *.feature files (Gherkin formatted text) should live
	param name="form.featuresDir" type="string" default='#expandPath(".") & "\testData"#';
	// this is your stub files results
	param name="form.outputDir" type="string" default='#expandPath(".") & "\tests\stubs"#';
	
	response = '';
	
	if (structKeyExists(form, "submitted")) {

		function cleanSlashes(str) {
			
			str = Replace(str, "/", "\", "ALL");

			var ret = str;
			var hasTrailingSlash = right(str,1) is '\';
			
			if (hasTrailingSlash) {
		    	ret = left(str, Len(str) - 1 );
		    }
		    return ret;
		}

	    featuresDir = cleanSlashes( form.featuresDir.Trim() );
	    
	    outputDir = cleanSlashes( form.outputDir.Trim() );

	    // grab all the directories and subdirectories, and files within
	    qFilesAndDirectories = DirectoryList(featuresDir, true, "query");
	    
	    // clear the directory so we have fresh files and delete out ones where the matching Gherkin feature file was deleted
	    if (DirectoryExists( outputDir )) {
			DirectoryDelete( outputDir, true );
		}

		// filter to only the directories
		q = new query();
		q.setName("qDirectories");
		q.setDBType("query");
		q.setAttributes(sourceQuery=qFilesAndDirectories);
		qDirectories = q.execute(sql="SELECT * FROM sourceQuery WHERE type = 'Dir'").getResult();

		//writeDump(qDirectories);
	
	    // loop through the directories and create TestBox Gherkin style BDD test file stubs 
	    for (featureDir in qDirectories) {
	    	
	    	// start using the ColdCukes obj for parsing
		    obj = new ColdCukes();

		    // get the feature sub folder if it exists 
			if (featureDir.directory == featuresDir) {
				subDir = "\";
			} else {
				subDir = replaceNoCase(featureDir.directory, featuresDir, "") & "\";
			}
			
			// test if this dir has any feature files directly in it
			currentFeatureDir = featureDir.directory & "\" & featureDir.name;
			qFeatureFiles = DirectoryList(currentFeatureDir, false, "query");
			q = new query();
			q.setName("qFeatureFiles");
			q.setDBType("query");
			q.setAttributes(sourceQuery=qFeatureFiles);
			qFeatureFiles = q.execute(sql="SELECT * FROM sourceQuery WHERE type = 'File' AND Name LIKE '%.feature'").getResult();

			//writeDump(qFeatureFiles);

			// only create the Test file if there are feature files in current directory
			if (qFeatureFiles.RecordCount) {

				obj.setFeaturesDirectory( currentFeatureDir );
				obj.setOutputDirectory( outputDir & subDir );
				
				// optionally pass in different break or tab characters for the outputted code
				//obj.setLineBreakCharacters( chr(13) & chr(10) );
				//obj.setTabCharacters( chr(9) );
				
				// run it and see the file that was returned, which is auto-generated (including the dir) if not there already
				outputFile = obj.generateGherkinTests();
				
				// you should be able to run the resulting files via TestBox with no errors
				response &= "generated Gherkin tests in '#outputFile#' successfully!<br>";

			}
		
		}
	
	}
	
</cfscript>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>ColdCukes Generator</title>

    <!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" 
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" 
		integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" 
		crossorigin="anonymous">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
  	
  	<cfoutput>
  		
  		<div class="container">
  		
		    <h1 class="text-info">ColdCukes Generator</h1>
		    
		    <form action="#CGI.SCRIPT_NAME#" method="post">
		    	
		    	<input type="hidden" name="submitted">
		    	
		    	<div class="form-group">
		    		<label for="featuresDir">Feature Directory</label>
		    		<input type="text" class="form-control" id="featuresDir" value="#featuresDir#" placeholder="#featuresDir#" name="featuresDir">
		    	</div>
		    	
		    	<div class="form-group">
		    		<label for="outputDir">Output Directory</label>
		    		<input type="text" class="form-control" id="outputDir" value="#outputDir#" placeholder="#outputDir#" name="outputDir">
		    	</div>
		    	
		    	<button type="submit" class="btn btn-primary">Generate Gherkin Stubs</button>
		    	
		    </form>	
		    
		    <br>
		    <cfif structKeyExists(form, "submitted")>
			    <cfif Len(response)>
			    	<div class="alert alert-success" role="alert">#response#</div>
			    <cfelse>
		    		<div class="alert alert-warning" role="alert">No Feature files found in the Feature Directory above</div>
			    </cfif>
		    </cfif>		    
    
    	</div>
    
    </cfoutput>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" 
		integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" 
		crossorigin="anonymous"></script>
  </body>
</html>