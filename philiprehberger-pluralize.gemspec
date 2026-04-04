# frozen_string_literal: true

require_relative 'lib/philiprehberger/pluralize/version'

Gem::Specification.new do |spec|
  spec.name = 'philiprehberger-pluralize'
  spec.version = Philiprehberger::Pluralize::VERSION
  spec.authors = ['Philip Rehberger']
  spec.email = ['me@philiprehberger.com']

  spec.summary = 'Standalone English pluralization, singularization, and string inflection'
  spec.description = 'Pluralize and singularize English words without ActiveSupport. Includes ' \
                     '200+ rules, irregular word handling, uncountable words, possessives, ' \
                     'ordinals, plural detection, hyphenated compounds, and string ' \
                     'inflections (camelCase, snake_case, titleize).'
  spec.homepage = 'https://philiprehberger.com/open-source-packages/ruby/philiprehberger-pluralize'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/philiprehberger/rb-pluralize'
  spec.metadata['changelog_uri'] = 'https://github.com/philiprehberger/rb-pluralize/blob/main/CHANGELOG.md'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/philiprehberger/rb-pluralize/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG.md']
  spec.require_paths = ['lib']
end
