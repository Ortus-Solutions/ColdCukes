component {

	// Module Properties
	this.title 				= "ColdCukes";
	this.author 			= "Aaron Longnion <aqlong>";
	this.webURL 			= "https://github.com/Fidano/ColdCukes";
	this.description 		= "ColdCukes is a ColdFusion/CFML project that parses Gherkin Feature files and creates associated TestBox BDD Unit Test files";
	this.version			= "0.0.1";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	this.autoMapModels      = false;
	this.entryPoint			= "coldcukes";
	this.modelNamespace		= "coldcukes";
	this.cfmapping			= "coldcukes";
	// Dependencies
	this.dependencies 		= [ "cbjavaloader" ];

	function configure() {
        parseParentSettings();
	}

	function onLoad() {
        var configStruct = controller.getConfigSettings();

		var javaloader = controller.getWirebox().getInstance("loader@cbjavaloader");
		javaloader.appendPaths(configStruct.coldcukes.directories.libs);

		binder.map("ColdCukes")
		    .to("#moduleMapping#.ColdCukes")
		    .initArg(name="AstBuilderObj", value=javaloader.create("gherkin.AstBuilder"))
		    .initArg(name="gherkinParser", value=javaloader.create("gherkin.Parser"))
		    .setter(name="FeaturesDirectory", argName="dir", value=configStruct.coldcukes.directories.features)
		    .setter(name="OutputDirectory", argName="dir", value=configStruct.coldcukes.directories.output);
	}

	function onUnload() {}

    private function parseParentSettings(){
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var configStruct 	= controller.getConfigSettings();
		var coldcukesDSL 	= oConfig.getPropertyMixin( "coldcukes", "variables", structnew() );

		//defaults
		configStruct.coldcukes = {
            directories = {
                features = '#ExpandPath("/tests/features/")#',
                output = '#ExpandPath("/tests/specs/features/")#',
                libs = '#ExpandPath("#moduleMapping#/lib/")#'
            }
		};

		// incorporate settings
		structAppend( configStruct.coldcukes, coldcukesDSL, true );
	}

}
