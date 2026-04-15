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
      # Handles hyphenated compound words:
      # - X-in-Y / X-of-Y patterns pluralize the first word
      # - Other compounds pluralize the last word
      #
      # @param word [String] the word to pluralize
      # @return [String] the plural form
      def plural(word)
        return word if word.nil? || word.strip.empty?

        return pluralize_hyphenated(word) if word.include?('-')

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

      # Generate the possessive form of a word
      #
      # @param word [String] the word
      # @return [String] the possessive form
      def possessive(word)
        return word if word.nil? || word.strip.empty?

        if word.end_with?('s')
          "#{word}'"
        else
          "#{word}'s"
        end
      end

      # Return true if the word appears to be plural
      #
      # Uses a simple heuristic: singularize the word, and if the result
      # differs from the input, it is likely plural.
      #
      # @param word [String] the word to check
      # @return [Boolean]
      def plural?(word)
        return false if word.nil? || word.strip.empty?

        singular(word) != word
      end

      # Convert a number to its ordinal word representation (up to 100)
      #
      # @param n [Integer] the number (1-100)
      # @return [String] the ordinal word
      def ordinal(n)
        raise ArgumentError, 'ordinal supports numbers from 1 to 100' if n < 1 || n > 100

        ORDINALS[n] || compound_ordinal(n)
      end

      # Format a count with the appropriate singular or plural word
      #
      # @param n [Integer] the count
      # @param word [String] the word to inflect
      # @param style [Symbol] :numeric (default) or :words (spell out numbers <= 12)
      # @return [String] the formatted count string
      def count(n, word, style: :numeric)
        inflected = n == 1 ? singular(word) : plural(word)
        prefix = style == :words && n >= 0 && n <= 12 ? number_to_word(n) : n.to_s
        "#{prefix} #{inflected}"
      end

      # Return true if the word is uncountable (same singular and plural form)
      #
      # Checks both the built-in uncountable list and any custom uncountables
      # registered via .uncountable.
      #
      # @param word [String] the word to check
      # @return [Boolean]
      def uncountable?(word)
        return false if word.nil? || word.strip.empty?

        lowered = word.downcase
        Rules::UNCOUNTABLES.include?(lowered) || @custom_uncountables.include?(lowered)
      end

      # Format a count with the correct singular or plural form
      #
      # Rails-style helper: pass a count, a singular form, and optionally an
      # explicit plural form. When plural is omitted, the plural is derived
      # from the singular via .plural.
      #
      # @param n [Integer] the count
      # @param singular_word [String] the singular form
      # @param plural_word [String, nil] optional explicit plural form
      # @return [String] the formatted count string, e.g. "5 octopi"
      def pluralize(n, singular_word, plural_word = nil)
        raise ArgumentError, 'count must be an Integer' unless n.is_a?(Integer)
        raise ArgumentError, 'singular word must not be nil or empty' if singular_word.nil? || singular_word.strip.empty?

        word = n == 1 ? singular_word : (plural_word || plural(singular_word))
        "#{n} #{word}"
      end

      # Capitalize a word and return its plural form
      #
      # Useful for sentence-style output such as "People" or "Children".
      # Preserves irregular and uncountable handling.
      #
      # @param word [String] the word to capitalize and pluralize
      # @return [String] the capitalized plural form
      def capitalize_and_pluralize(word)
        return word if word.nil? || word.strip.empty?

        plural(word.downcase).capitalize
      end

      # Register an irregular singular/plural pair
      #
      # @param singular_word [String] the singular form
      # @param plural_word [String] the plural form
      # @return [void]
      def irregular(singular_word, plural_word)
        raise ArgumentError, 'singular and plural must not be nil or empty' if blank?(singular_word) || blank?(plural_word)

        @custom_irregulars[singular_word.downcase] = plural_word.downcase
      end

      # Register a word as uncountable
      #
      # @param word [String] the uncountable word
      # @return [void]
      def uncountable(word)
        raise ArgumentError, 'uncountable word must not be nil or empty' if blank?(word)

        @custom_uncountables.add(word.downcase)
      end

      # List custom-registered irregular singular/plural pairs
      #
      # Returns a frozen copy so callers cannot mutate internal state.
      #
      # @return [Hash{String => String}] singular => plural mapping
      def irregulars
        @custom_irregulars.dup.freeze
      end

      # List custom-registered uncountable words
      #
      # Returns a frozen copy so callers cannot mutate internal state.
      #
      # @return [Array<String>] sorted list of uncountable words
      def uncountables
        @custom_uncountables.to_a.sort.freeze
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

      ORDINALS = {
        1 => 'first', 2 => 'second', 3 => 'third', 4 => 'fourth', 5 => 'fifth',
        6 => 'sixth', 7 => 'seventh', 8 => 'eighth', 9 => 'ninth', 10 => 'tenth',
        11 => 'eleventh', 12 => 'twelfth', 13 => 'thirteenth', 14 => 'fourteenth',
        15 => 'fifteenth', 16 => 'sixteenth', 17 => 'seventeenth', 18 => 'eighteenth',
        19 => 'nineteenth', 20 => 'twentieth', 30 => 'thirtieth', 40 => 'fortieth',
        50 => 'fiftieth', 60 => 'sixtieth', 70 => 'seventieth', 80 => 'eightieth',
        90 => 'ninetieth', 100 => 'one hundredth'
      }.freeze

      TENS = {
        20 => 'twenty', 30 => 'thirty', 40 => 'forty', 50 => 'fifty',
        60 => 'sixty', 70 => 'seventy', 80 => 'eighty', 90 => 'ninety'
      }.freeze

      NUMBER_WORDS = %w[zero one two three four five six seven eight nine ten eleven twelve].freeze

      HYPHENATED_PREPOSITIONS = %w[in of].freeze

      def compound_ordinal(n)
        tens = (n / 10) * 10
        ones = n % 10
        "#{TENS[tens]}-#{ORDINALS[ones]}"
      end

      def number_to_word(n)
        NUMBER_WORDS[n] || n.to_s
      end

      def pluralize_hyphenated(word)
        parts = word.split('-')

        if parts.length >= 3 && HYPHENATED_PREPOSITIONS.include?(parts[1].downcase)
          parts[0] = plural(parts[0])
        else
          parts[-1] = plural(parts[-1])
        end

        parts.join('-')
      end

      def blank?(value)
        value.nil? || value.to_s.strip.empty?
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
