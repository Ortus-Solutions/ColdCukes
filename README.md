# ColdCukes
ColdCukes is a ColdFusion/CFML project that parses Gherkin Feature files and creates associated TestBox BDD Unit Test files

## Diagram

![Diagram of ColdCukes in Action](/assets/images/CukesDiagram2.png)

## Installation

1. Clone this repo locally to your web root
2. Run it locally from http://localhost/ColdCukes - you should be able to push the button and run it with no changes
3. It should output which TestBox files were generated. You can look at them to see the magic. NOTE that if the test files were already there, it will seem like nothing changed

## Usage

* see index.cfm

1. If TestBox is set up locally, you can run any Unit Tests in the /tests/specs directory at http://localhost/ColdCukes-public/tests/runner.cfm
2. Move/copy/merge stub files from /tests/stubs to /tests/specs in order to run them via the runner above
3. Add new directories with new Gherkin *.feature files in /testData, and run http://localhost/ColdCukes again, to create new Unit Test stub files

## Gherkin Feature Files

* see http://docs.behat.org/en/v2.5/guides/1.gherkin.html

## TestBox BDD/Gherkin Test Files

* Resulting files are in this basic format, depending on the *.feature files: https://github.com/Ortus-Solutions/TestBox/blob/master/tests/specs/GivenWhenThenTest.cfc

## TODO List

1. Code reviews/suggestions welcome
2. Ability to parse more complex Gherkin feature files *(NOTE: it doesn't even handle AND steps yet)*
3. Ability to add more complex TestBox test stub files?
4. Ability to choose other config options like tab characters and directory filters?

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

* Version: Alpha 0.001 -- 2016-01-26
* Version: Alpha 0.002 -- 2016-01-27

## Credits

* Aaron Longnion
* Fidano
* TestBox from the ColdBox team
* Cucumber/Gherkin - https://github.com/cucumber/gherkin

## License

MIT License: https://github.com/Fidano/ColdCukes/blob/master/LICENSE
