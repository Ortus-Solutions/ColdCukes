# ColdCukes
ColdCukes is a ColdFusion/CFML project that parses Gherkin Feature files and creates associated TestBox BDD Unit Test files

## Installation

1. Clone it locally to your web root
2. Run it locally at http://localhost/ColdCukes
3. It should output which TestBox files were generated. You can look at them to see the magic.

## Usage

* see index.cfm

## Gherkin Feature Files

* see http://docs.behat.org/en/v2.5/guides/1.gherkin.html

## TestBox BDD/Gherkin Test Files

* Resulting files are in this basic format, depending on the *.feature files: https://github.com/Ortus-Solutions/TestBox/blob/master/tests/specs/GivenWhenThenTest.cfc

## TODO List

1. Code reviews/suggestions welcome
2. Ability to parse more complex Gherkin feature files *(NOTE: it doesn't even handle AND steps yet)*
3. Ability to add more complex TestBox test stub files?
4. A UI for picking which source files/directories, which directories the stub files go in, and other config options?

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

* Version: Alpha 0.001 -- 2016-01-26

## Credits

* Aaron Longnion
* Fidano
* TestBox from the ColdBox team
* Cucumber/Gherkin - https://github.com/cucumber/gherkin

## License

MIT License: https://github.com/Fidano/ColdCukes/blob/master/LICENSE
