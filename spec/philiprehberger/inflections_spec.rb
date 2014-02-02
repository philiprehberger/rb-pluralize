# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Philiprehberger::Pluralize::Inflections do
  describe '.camel_case' do
    it 'converts snake_case to PascalCase' do
      expect(described_class.camel_case('hello_world')).to eq('HelloWorld')
    end

    it 'converts hyphenated strings to PascalCase' do
      expect(described_class.camel_case('hello-world')).to eq('HelloWorld')
    end

    it 'converts single word to PascalCase' do
      expect(described_class.camel_case('hello')).to eq('Hello')
    end

    it 'handles multiple underscores' do
      expect(described_class.camel_case('one_two_three')).to eq('OneTwoThree')
    end

    it 'handles empty string' do
      expect(described_class.camel_case('')).to eq('')
    end
  end

  describe '.snake_case' do
    it 'converts PascalCase to snake_case' do
      expect(described_class.snake_case('HelloWorld')).to eq('hello_world')
    end

    it 'converts camelCase to snake_case' do
      expect(described_class.snake_case('helloWorld')).to eq('hello_world')
    end

    it 'handles consecutive uppercase letters' do
      expect(described_class.snake_case('HTMLParser')).to eq('html_parser')
    end

    it 'handles single word' do
      expect(described_class.snake_case('hello')).to eq('hello')
    end

    it 'handles empty string' do
      expect(described_class.snake_case('')).to eq('')
    end

    it 'converts hyphenated strings' do
      expect(described_class.snake_case('hello-world')).to eq('hello_world')
    end
  end

  describe '.titleize' do
    it 'converts snake_case to Title Case' do
      expect(described_class.titleize('hello_world')).to eq('Hello World')
    end

    it 'converts PascalCase to Title Case' do
      expect(described_class.titleize('HelloWorld')).to eq('Hello World')
    end

    it 'handles single word' do
      expect(described_class.titleize('hello')).to eq('Hello')
    end

    it 'handles empty string' do
      expect(described_class.titleize('')).to eq('')
    end
  end

  describe '.humanize' do
    it 'removes _id suffix and capitalizes' do
      expect(described_class.humanize('user_id')).to eq('User')
    end

    it 'replaces underscores with spaces' do
      expect(described_class.humanize('first_name')).to eq('First name')
    end

    it 'capitalizes the first letter' do
      expect(described_class.humanize('hello_world')).to eq('Hello world')
    end

    it 'handles single word' do
      expect(described_class.humanize('hello')).to eq('Hello')
    end

    it 'handles empty string' do
      expect(described_class.humanize('')).to eq('')
    end
  end
end
