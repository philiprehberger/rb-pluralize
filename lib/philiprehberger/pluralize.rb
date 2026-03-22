# frozen_string_literal: true

require 'set'
require_relative 'pluralize/version'
require_relative 'pluralize/rules'
require_relative 'pluralize/inflections'

module Philiprehberger
  module Pluralize
    class Error < StandardError; end

    @custom_irregulars = {}
    @custom_uncountables = Set.new

    class << self
      # Return the plural form of a word
      #
      # @param word [String] the word to pluralize
      # @return [String] the plural form
      def plural(word)
        return word if word.nil? || word.strip.empty?

        lowered = word.downcase
        return word if uncountable?(lowered)

        irregular = find_irregular(lowered)
        return preserve_case(word, irregular) if irregular

        apply_rules(word, Rules::PLURALS)
      end

      # Return the singular form of a word
      #
      # @param word [String] the word to singularize
      # @return [String] the singular form
      def singular(word)
        return word if word.nil? || word.strip.empty?

        lowered = word.downcase
        return word if uncountable?(lowered)

        irregular = find_irregular_inverse(lowered)
        return preserve_case(word, irregular) if irregular

        apply_rules(word, Rules::SINGULARS)
      end

      # Format a count with the appropriate singular or plural word
      #
      # @param n [Integer] the count
      # @param word [String] the word to inflect
      # @return [String] the formatted count string
      def count(n, word)
        inflected = n == 1 ? singular(word) : plural(word)
        "#{n} #{inflected}"
      end

      # Register an irregular singular/plural pair
      #
      # @param singular_word [String] the singular form
      # @param plural_word [String] the plural form
      # @return [void]
      def irregular(singular_word, plural_word)
        @custom_irregulars[singular_word.downcase] = plural_word.downcase
      end

      # Register a word as uncountable
      #
      # @param word [String] the uncountable word
      # @return [void]
      def uncountable(word)
        @custom_uncountables.add(word.downcase)
      end

      # Convert a string to PascalCase
      #
      # @param str [String] the string to convert
      # @return [String] PascalCase string
      def camel_case(str)
        Inflections.camel_case(str)
      end

      # Convert a string to snake_case
      #
      # @param str [String] the string to convert
      # @return [String] snake_case string
      def snake_case(str)
        Inflections.snake_case(str)
      end

      # Convert a string to Title Case
      #
      # @param str [String] the string to convert
      # @return [String] titleized string
      def titleize(str)
        Inflections.titleize(str)
      end

      # Convert an underscored string to a human-readable form
      #
      # @param str [String] the string to convert
      # @return [String] humanized string
      def humanize(str)
        Inflections.humanize(str)
      end

      # Reset custom irregular and uncountable rules
      #
      # @return [void]
      def reset!
        @custom_irregulars = {}
        @custom_uncountables = Set.new
      end

      private

      def uncountable?(word)
        Rules::UNCOUNTABLES.include?(word) || @custom_uncountables.include?(word)
      end

      def find_irregular(word)
        @custom_irregulars[word] || Rules::IRREGULARS[word]
      end

      def find_irregular_inverse(word)
        @custom_irregulars.key(word) || Rules::IRREGULARS.key(word)
      end

      def apply_rules(word, rules)
        rules.reverse_each do |pattern, replacement|
          result = word.gsub(pattern, replacement)
          return result if result != word
        end
        word
      end

      def preserve_case(original, replacement)
        return replacement if original == original.downcase
        return replacement.upcase if original == original.upcase
        return replacement.capitalize if original[0] == original[0].upcase

        replacement
      end
    end
  end
end
