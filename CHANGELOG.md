# Changelog

All notable changes to this gem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2026-04-15

### Added
- Add `Pluralize.pluralize(n, singular, plural = nil)` Rails-style count helper with optional explicit plural form
- Add `Pluralize.capitalize_and_pluralize(word)` to pluralize and capitalize in one call
- Add public `Pluralize.uncountable?(word)` predicate for uncountability checks
- Add `Pluralize.irregulars` and `Pluralize.uncountables` introspection methods returning frozen snapshots

### Changed
- `Pluralize.irregular` and `Pluralize.uncountable` now raise `ArgumentError` when given nil or blank input

## [0.2.0] - 2026-04-03

### Added
- Add `Pluralize.possessive(word)` for possessive form generation
- Add hyphenated compound word support in `Pluralize.plural` (X-in-Y, X-of-Y patterns)
- Add `Pluralize.ordinal(n)` for number-to-ordinal-word conversion (1-100)
- Add `Pluralize.plural?(word)` predicate to detect plural words
- Add `:words` style option to `Pluralize.count` for spelled-out numbers (0-12)

## [0.1.6] - 2026-03-31

### Added
- Add GitHub issue templates, dependabot config, and PR template

## [0.1.5] - 2026-03-31

### Changed
- Standardize README badges, support section, and license format

## [0.1.4] - 2026-03-26

### Fixed
- Add Sponsor badge to README
- Fix license section link format

## [0.1.3] - 2026-03-24

### Fixed
- Standardize README code examples to use double-quote require statements
- Remove inline comments from Development section to match template

## [0.1.2] - 2026-03-24

### Fixed
- Fix Installation section quote style to double quotes

## [0.1.1] - 2026-03-22

### Changed
- Improve source code, tests, and rubocop compliance

## [0.1.0] - 2026-03-21

### Added
- Initial release
- Pluralize English words with 200+ regex rules and irregular word handling
- Singularize English words back to their singular form
- Count formatting with automatic singular/plural inflection
- Custom irregular word pair registration
- Custom uncountable word registration
- String inflections: camel_case, snake_case, titleize, humanize

[Unreleased]: https://github.com/philiprehberger/rb-pluralize/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/philiprehberger/rb-pluralize/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/philiprehberger/rb-pluralize/compare/v0.1.6...v0.2.0
[0.1.6]: https://github.com/philiprehberger/rb-pluralize/compare/v0.1.5...v0.1.6
[0.1.5]: https://github.com/philiprehberger/rb-pluralize/compare/v0.1.4...v0.1.5
[0.1.4]: https://github.com/philiprehberger/rb-pluralize/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/philiprehberger/rb-pluralize/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/philiprehberger/rb-pluralize/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/philiprehberger/rb-pluralize/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/philiprehberger/rb-pluralize/releases/tag/v0.1.0
