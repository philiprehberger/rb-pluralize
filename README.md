# philiprehberger-pluralize

[![Tests](https://github.com/philiprehberger/rb-pluralize/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-pluralize/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-pluralize.svg)](https://rubygems.org/gems/philiprehberger-pluralize)
[![Last updated](https://img.shields.io/github/last-commit/philiprehberger/rb-pluralize)](https://github.com/philiprehberger/rb-pluralize/commits/main)

Standalone English pluralization, singularization, and string inflection

## Requirements

- Ruby >= 3.1

## Installation

Add to your Gemfile:

```ruby
gem "philiprehberger-pluralize"
```

Or install directly:

```bash
gem install philiprehberger-pluralize
```

## Usage

```ruby
require "philiprehberger/pluralize"

Philiprehberger::Pluralize.plural('person')    # => "people"
Philiprehberger::Pluralize.singular('people')  # => "person"
Philiprehberger::Pluralize.count(5, 'item')    # => "5 items"
```

### Custom Irregular Words

```ruby
Philiprehberger::Pluralize.irregular('radius', 'radii')
Philiprehberger::Pluralize.plural('radius')    # => "radii"
Philiprehberger::Pluralize.singular('radii')   # => "radius"
```

### Uncountable Words

```ruby
Philiprehberger::Pluralize.uncountable('equipment')
Philiprehberger::Pluralize.plural('equipment')  # => "equipment"
```

### String Inflections

```ruby
Philiprehberger::Pluralize.camel_case('hello_world')  # => "HelloWorld"
Philiprehberger::Pluralize.snake_case('HelloWorld')    # => "hello_world"
Philiprehberger::Pluralize.titleize('hello_world')     # => "Hello World"
Philiprehberger::Pluralize.humanize('user_id')         # => "User"
```

## API

| Method | Description |
|--------|-------------|
| `Pluralize.plural(word)` | Return the plural form of a word |
| `Pluralize.singular(word)` | Return the singular form of a word |
| `Pluralize.count(n, word)` | Format a count with the appropriate singular or plural word |
| `Pluralize.irregular(singular, plural)` | Register a custom irregular singular/plural pair |
| `Pluralize.uncountable(word)` | Register a word as uncountable |
| `Pluralize.camel_case(str)` | Convert an underscored or hyphenated string to PascalCase |
| `Pluralize.snake_case(str)` | Convert a PascalCase or camelCase string to snake_case |
| `Pluralize.titleize(str)` | Convert an underscored or hyphenated string to Title Case |
| `Pluralize.humanize(str)` | Convert an underscored string to a human-readable form |
| `Pluralize.reset!` | Reset all custom irregular and uncountable rules |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## Support

If you find this project useful:

⭐ [Star the repo](https://github.com/philiprehberger/rb-pluralize)

🐛 [Report issues](https://github.com/philiprehberger/rb-pluralize/issues?q=is%3Aissue+is%3Aopen+label%3Abug)

💡 [Suggest features](https://github.com/philiprehberger/rb-pluralize/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)

❤️ [Sponsor development](https://github.com/sponsors/philiprehberger)

🌐 [All Open Source Projects](https://philiprehberger.com/open-source-packages)

💻 [GitHub Profile](https://github.com/philiprehberger)

🔗 [LinkedIn Profile](https://www.linkedin.com/in/philiprehberger)

## License

[MIT](LICENSE)
