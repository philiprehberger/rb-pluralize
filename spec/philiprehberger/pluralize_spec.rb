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
end
