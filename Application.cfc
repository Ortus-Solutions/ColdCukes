component{
	this.name = "ColdCukes_" & hash( getCurrentTemplatePath() );
	
	// any other application.cfc stuff goes below:
	this.sessionManagement = false;

	// any mappings go here, we create one that points to the root called test.
	this.mappings[ "/ColdCukes" ] = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/testbox" ] = expandPath("/testbox");

	this.javaSettings = {
		LoadPaths = ["/lib"],
		loadColdFusionClassPath: false,
		watchInterval: 2,
		reloadOnChange: true
	};

	// request start
	public boolean function onRequestStart( String targetPage ){
		return true;
	}
}