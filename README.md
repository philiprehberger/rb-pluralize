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

### Possessive Forms

```ruby
Philiprehberger::Pluralize.possessive('dog')       # => "dog's"
Philiprehberger::Pluralize.possessive('dogs')      # => "dogs'"
Philiprehberger::Pluralize.possessive('James')     # => "James'"
Philiprehberger::Pluralize.possessive('children')  # => "children's"
```

### Hyphenated Compound Words

```ruby
Philiprehberger::Pluralize.plural('mother-in-law')  # => "mothers-in-law"
Philiprehberger::Pluralize.plural('well-being')     # => "well-beings"
```

### Ordinal Words

```ruby
Philiprehberger::Pluralize.ordinal(1)   # => "first"
Philiprehberger::Pluralize.ordinal(12)  # => "twelfth"
Philiprehberger::Pluralize.ordinal(21)  # => "twenty-first"
```

### Plural Detection

```ruby
Philiprehberger::Pluralize.plural?('cats')    # => true
Philiprehberger::Pluralize.plural?('cat')     # => false
Philiprehberger::Pluralize.plural?('people')  # => true
```

### Count with Words

```ruby
Philiprehberger::Pluralize.count(5, 'item', style: :words)   # => "five items"
Philiprehberger::Pluralize.count(1, 'person', style: :words)  # => "one person"
Philiprehberger::Pluralize.count(20, 'item', style: :words)  # => "20 items"
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
| `Pluralize.plural(word)` | Return the plural form of a word (supports hyphenated compounds) |
| `Pluralize.singular(word)` | Return the singular form of a word |
| `Pluralize.possessive(word)` | Generate the possessive form of a word |
| `Pluralize.plural?(word)` | Return true if the word appears to be plural |
| `Pluralize.ordinal(n)` | Convert a number (1-100) to its ordinal word |
| `Pluralize.count(n, word, style:)` | Format a count with singular/plural word (`:numeric` or `:words` style) |
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
