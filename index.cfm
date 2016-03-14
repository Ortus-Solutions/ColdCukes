<cfscript>
	/*
	start here to make changes to how the stub files are generated
	*/
	
	// this is where your *.feature files (Gherkin formatted text) should live
	param name="form.featuresDir" type="string" default='#expandPath(".") & "/testData/"#';
	param name="form.outputDir" type="string" default='#expandPath(".") & "/tests/stubs/"#';
	
	response = '';
	
	if (structKeyExists(form, "submitted")) {

	    // grab just the ones we want to loop over, as an array
	    arrDirectories = DirectoryList(form.featuresDir.Trim(), false, "array", "coldcukes*", "");
	    
	    outputDir = form.outputDir.Trim();
	    
	    // clear the directory so we have fresh files and delete out ones where the matching Gherkin feature file was deleted
	    if (DirectoryExists( outputDir )) {
			DirectoryDelete( outputDir, true );
		}
	
	    // loop through the directories and create TestBox Gherkin style BDD test file stubs 
	    for (featureDir in arrDirectories) {
	    	
	    	// start using the ColdCukes obj for parsing
		    obj = new ColdCukes();
			obj.setFeaturesDirectory( featureDir );
			obj.setOutputDirectory( outputDir );
			
			// optionally pass in different break or tab characters for the outputted code
			//obj.setLineBreakCharacters( chr(13) & chr(10) );
			//obj.setTabCharacters( chr(9) );
			
			// run it and see the file that was returned, which is auto-generated (including the dir) if not there already
			outputFile = obj.generateGherkinTests();
			
			// you should be able to run the resulting files via TestBox with no errors
			response &= "generated Gherkin tests in '#outputFile#' successfully!<br>";
		
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
		    		<input type="text" class="form-control" id="featuresDir" name="featuresDir" value="#form.featuresDir#" placeholder="#expandPath('.')#/features">
		    	</div>
		    	
		    	<div class="form-group">
		    		<label for="outputDir">Output Directory</label>
		    		<input type="text" class="form-control" id="outputDir" name="outputDir" value="#outputDir#" placeholder="#expandPath('.')#/stubs">
		    	</div>
		    	
		    	<button type="submit" class="btn btn-primary">Generate Gherkin Stubs</button>
		    	
		    </form>	
		    
		    <br>
		    <cfif Len(response)>
		    	<div class="alert alert-success" role="alert">#response#</div>
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