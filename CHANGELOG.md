# Changelog

## [0.9.0](https://github.com/fortissimo1997/simplecov-lcov/compare/simplecov-lcov-v0.8.0...simplecov-lcov/v0.9.0) (2025-08-24)


### Features

* Add automated release workflow with release-please ([14ca244](https://github.com/fortissimo1997/simplecov-lcov/commit/14ca244a3c2756a1bfb6b6eba29a088c0d25acaf))
* Refactor version management and modernize gemspec ([2aa5f96](https://github.com/fortissimo1997/simplecov-lcov/commit/2aa5f963c52a05dc49db63f5ffe9858cb8aba20d))


### Bug Fixes

* Change branch references from main to master ([9a841c9](https://github.com/fortissimo1997/simplecov-lcov/commit/9a841c984d51470290f7fdbf604956ea3e695658))
* Update branch references from main to master ([ea50994](https://github.com/fortissimo1997/simplecov-lcov/commit/ea509945efa51929265329dac74744a15a16295d))
* Fix incompatibility with simplecov < 0.18 by adding `respond_to?` check for `branch_coverage?` method ([0b3a499](https://github.com/fortissimo1997/simplecov-lcov/commit/0b3a499ebb98e677f275aa1e42bbb18fecde70da)) - thanks @RobinDaugherty
* Fix instance variable not initialized warning for `@single_report_path` ([30e6751](https://github.com/fortissimo1997/simplecov-lcov/commit/30e6751efed7eac2e223e59ce044b955a3ea7c42)) - thanks @MattFenelon
* Add LF (Lines Found) and LH (Lines Hit) to LCOV output ([32c2516](https://github.com/fortissimo1997/simplecov-lcov/commit/32c251674dd813b3bc7f90696e0d83acc6272102)) - thanks @ricardokrieg
* Avoid blank lines in LCOV output ([b2d0a3b](https://github.com/fortissimo1997/simplecov-lcov/commit/b2d0a3b83d225acd8355d00a7be178d6ee0e8a90)) - thanks @apiology
