# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Philiprehberger::Pluralize do
  it 'has a version number' do
    expect(Philiprehberger::Pluralize::VERSION).not_to be_nil
  end

  after { described_class.reset! }

  describe '.plural' do
    it 'pluralizes regular words ending in a consonant' do
      expect(described_class.plural('cat')).to eq('cats')
    end

    it 'pluralizes words ending in s, x, ch, sh' do
      expect(described_class.plural('box')).to eq('boxes')
      expect(described_class.plural('bus')).to eq('buses')
      expect(described_class.plural('match')).to eq('matches')
      expect(described_class.plural('wish')).to eq('wishes')
    end

    it 'pluralizes words ending in consonant + y' do
      expect(described_class.plural('baby')).to eq('babies')
      expect(described_class.plural('city')).to eq('cities')
    end

    it 'pluralizes words ending in f/fe' do
      expect(described_class.plural('knife')).to eq('knives')
      expect(described_class.plural('wolf')).to eq('wolves')
      expect(described_class.plural('leaf')).to eq('leaves')
      expect(described_class.plural('half')).to eq('halves')
    end

    it 'pluralizes irregular words' do
      expect(described_class.plural('person')).to eq('people')
      expect(described_class.plural('child')).to eq('children')
      expect(described_class.plural('mouse')).to eq('mice')
      expect(described_class.plural('goose')).to eq('geese')
      expect(described_class.plural('tooth')).to eq('teeth')
      expect(described_class.plural('foot')).to eq('feet')
    end

    it 'does not change uncountable words' do
      expect(described_class.plural('sheep')).to eq('sheep')
      expect(described_class.plural('fish')).to eq('fish')
      expect(described_class.plural('equipment')).to eq('equipment')
      expect(described_class.plural('information')).to eq('information')
    end

    it 'returns empty or nil words unchanged' do
      expect(described_class.plural('')).to eq('')
      expect(described_class.plural('  ')).to eq('  ')
      expect(described_class.plural(nil)).to be_nil
    end

    it 'pluralizes words ending in vowel + y' do
      expect(described_class.plural('day')).to eq('days')
      expect(described_class.plural('key')).to eq('keys')
      expect(described_class.plural('boy')).to eq('boys')
    end

    context 'with hyphenated compound words' do
      it 'pluralizes the first word for X-in-Y patterns' do
        expect(described_class.plural('mother-in-law')).to eq('mothers-in-law')
        expect(described_class.plural('sister-in-law')).to eq('sisters-in-law')
      end

      it 'pluralizes the first word for X-of-Y patterns' do
        expect(described_class.plural('attorney-of-record')).to eq('attorneys-of-record')
      end

      it 'pluralizes the last word for other compound words' do
        expect(described_class.plural('well-being')).to eq('well-beings')
        expect(described_class.plural('six-pack')).to eq('six-packs')
        expect(described_class.plural('mix-up')).to eq('mix-ups')
      end
    end
  end

  describe '.singular' do
    it 'singularizes regular plurals' do
      expect(described_class.singular('cats')).to eq('cat')
    end

    it 'singularizes words ending in es' do
      expect(described_class.singular('boxes')).to eq('box')
      expect(described_class.singular('matches')).to eq('match')
      expect(described_class.singular('wishes')).to eq('wish')
    end

    it 'singularizes words ending in ies' do
      expect(described_class.singular('babies')).to eq('baby')
      expect(described_class.singular('cities')).to eq('city')
    end

    it 'singularizes words ending in ves' do
      expect(described_class.singular('knives')).to eq('knife')
      expect(described_class.singular('wolves')).to eq('wolf')
      expect(described_class.singular('leaves')).to eq('leaf')
      expect(described_class.singular('halves')).to eq('half')
    end

    it 'singularizes irregular words' do
      expect(described_class.singular('people')).to eq('person')
      expect(described_class.singular('children')).to eq('child')
      expect(described_class.singular('mice')).to eq('mouse')
      expect(described_class.singular('geese')).to eq('goose')
      expect(described_class.singular('teeth')).to eq('tooth')
      expect(described_class.singular('feet')).to eq('foot')
    end

    it 'does not change uncountable words' do
      expect(described_class.singular('sheep')).to eq('sheep')
      expect(described_class.singular('fish')).to eq('fish')
      expect(described_class.singular('equipment')).to eq('equipment')
    end

    it 'returns empty or nil words unchanged' do
      expect(described_class.singular('')).to eq('')
      expect(described_class.singular(nil)).to be_nil
    end
  end

  describe '.possessive' do
    it 'adds apostrophe-s for regular words' do
      expect(described_class.possessive('dog')).to eq("dog's")
      expect(described_class.possessive('cat')).to eq("cat's")
    end

    it 'adds only apostrophe for words ending in s' do
      expect(described_class.possessive('dogs')).to eq("dogs'")
      expect(described_class.possessive('cats')).to eq("cats'")
    end

    it 'adds only apostrophe for proper nouns ending in s' do
      expect(described_class.possessive('James')).to eq("James'")
      expect(described_class.possessive('Charles')).to eq("Charles'")
    end

    it 'adds apostrophe-s for irregular plurals not ending in s' do
      expect(described_class.possessive('children')).to eq("children's")
      expect(described_class.possessive('women')).to eq("women's")
      expect(described_class.possessive('people')).to eq("people's")
    end

    it 'returns empty or nil words unchanged' do
      expect(described_class.possessive('')).to eq('')
      expect(described_class.possessive('  ')).to eq('  ')
      expect(described_class.possessive(nil)).to be_nil
    end
  end

  describe '.plural?' do
    it 'returns true for plural words' do
      expect(described_class.plural?('cats')).to be true
      expect(described_class.plural?('people')).to be true
      expect(described_class.plural?('children')).to be true
      expect(described_class.plural?('boxes')).to be true
    end

    it 'returns false for singular words' do
      expect(described_class.plural?('cat')).to be false
      expect(described_class.plural?('person')).to be false
      expect(described_class.plural?('box')).to be false
    end

    it 'returns false for empty or nil words' do
      expect(described_class.plural?('')).to be false
      expect(described_class.plural?(nil)).to be false
    end
  end

  describe '.ordinal' do
    it 'returns ordinal words for 1 through 12' do
      expect(described_class.ordinal(1)).to eq('first')
      expect(described_class.ordinal(2)).to eq('second')
      expect(described_class.ordinal(3)).to eq('third')
      expect(described_class.ordinal(5)).to eq('fifth')
      expect(described_class.ordinal(8)).to eq('eighth')
      expect(described_class.ordinal(12)).to eq('twelfth')
    end

    it 'returns ordinal words for teens' do
      expect(described_class.ordinal(13)).to eq('thirteenth')
      expect(described_class.ordinal(19)).to eq('nineteenth')
    end

    it 'returns ordinal words for round tens' do
      expect(described_class.ordinal(20)).to eq('twentieth')
      expect(described_class.ordinal(30)).to eq('thirtieth')
      expect(described_class.ordinal(50)).to eq('fiftieth')
      expect(described_class.ordinal(90)).to eq('ninetieth')
    end

    it 'returns compound ordinal words for 21-99' do
      expect(described_class.ordinal(21)).to eq('twenty-first')
      expect(described_class.ordinal(42)).to eq('forty-second')
      expect(described_class.ordinal(73)).to eq('seventy-third')
      expect(described_class.ordinal(99)).to eq('ninety-ninth')
    end

    it 'returns one hundredth for 100' do
      expect(described_class.ordinal(100)).to eq('one hundredth')
    end

    it 'raises ArgumentError for out-of-range numbers' do
      expect { described_class.ordinal(0) }.to raise_error(ArgumentError)
      expect { described_class.ordinal(101) }.to raise_error(ArgumentError)
    end
  end

  describe '.count' do
    it 'uses singular for count of 1' do
      expect(described_class.count(1, 'item')).to eq('1 item')
    end

    it 'uses plural for count of 0' do
      expect(described_class.count(0, 'item')).to eq('0 items')
    end

    it 'uses plural for counts greater than 1' do
      expect(described_class.count(5, 'item')).to eq('5 items')
    end

    it 'handles irregular words' do
      expect(described_class.count(1, 'person')).to eq('1 person')
      expect(described_class.count(3, 'person')).to eq('3 people')
    end

    it 'handles uncountable words' do
      expect(described_class.count(1, 'sheep')).to eq('1 sheep')
      expect(described_class.count(5, 'sheep')).to eq('5 sheep')
    end

    context 'with style: :words' do
      it 'spells out numbers 0 through 12' do
        expect(described_class.count(0, 'item', style: :words)).to eq('zero items')
        expect(described_class.count(1, 'item', style: :words)).to eq('one item')
        expect(described_class.count(5, 'item', style: :words)).to eq('five items')
        expect(described_class.count(12, 'item', style: :words)).to eq('twelve items')
      end

      it 'falls back to numeric for numbers greater than 12' do
        expect(described_class.count(13, 'item', style: :words)).to eq('13 items')
        expect(described_class.count(100, 'cat', style: :words)).to eq('100 cats')
      end

      it 'handles irregular words' do
        expect(described_class.count(1, 'person', style: :words)).to eq('one person')
        expect(described_class.count(3, 'person', style: :words)).to eq('three people')
      end
    end
  end

  describe '.irregular' do
    it 'registers a custom irregular pair' do
      described_class.irregular('radius', 'radii')
      expect(described_class.plural('radius')).to eq('radii')
      expect(described_class.singular('radii')).to eq('radius')
    end
  end

  describe '.uncountable' do
    it 'registers a custom uncountable word' do
      described_class.uncountable('furniture')
      expect(described_class.plural('furniture')).to eq('furniture')
      expect(described_class.singular('furniture')).to eq('furniture')
    end
  end

  describe '.camel_case' do
    it 'converts snake_case to PascalCase' do
      expect(described_class.camel_case('hello_world')).to eq('HelloWorld')
    end

    it 'converts hyphenated strings to PascalCase' do
      expect(described_class.camel_case('hello-world')).to eq('HelloWorld')
    end

    it 'handles single word' do
      expect(described_class.camel_case('hello')).to eq('Hello')
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
  end

  describe '.titleize' do
    it 'converts snake_case to Title Case' do
      expect(described_class.titleize('hello_world')).to eq('Hello World')
    end

    it 'converts PascalCase to Title Case' do
      expect(described_class.titleize('HelloWorld')).to eq('Hello World')
    end
  end

  describe '.humanize' do
    it 'removes _id suffix and capitalizes' do
      expect(described_class.humanize('user_id')).to eq('User')
    end

    it 'replaces underscores with spaces and capitalizes first letter' do
      expect(described_class.humanize('first_name')).to eq('First name')
    end

    it 'handles empty string' do
      expect(described_class.humanize('')).to eq('')
    end
  end
end
