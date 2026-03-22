# frozen_string_literal: true

module Philiprehberger
  module Pluralize
    # String inflection methods: camelCase, snake_case, titleize, humanize
    module Inflections
      # Convert an underscored or hyphenated string to PascalCase
      #
      # @param str [String] the string to convert
      # @return [String] PascalCase string
      def self.camel_case(str)
        str.to_s
           .gsub(/[-_\s]+/, '_')
           .split('_')
           .map(&:capitalize)
           .join
      end

      # Convert a PascalCase or camelCase string to snake_case
      #
      # @param str [String] the string to convert
      # @return [String] snake_case string
      def self.snake_case(str)
        str.to_s
           .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
           .gsub(/([a-z\d])([A-Z])/, '\1_\2')
           .gsub(/[-\s]+/, '_')
           .downcase
      end

      # Convert an underscored or hyphenated string to Title Case
      #
      # @param str [String] the string to convert
      # @return [String] titleized string
      def self.titleize(str)
        snake_case(str)
          .gsub(/_/, ' ')
          .gsub(/\b\w/, &:upcase)
      end

      # Convert an underscored string to a human-readable form
      #
      # @param str [String] the string to convert
      # @return [String] humanized string
      def self.humanize(str)
        result = str.to_s
                    .gsub(/_id$/, '')
                    .gsub(/_/, ' ')
                    .strip
        return result if result.empty?

        result[0].upcase + result[1..]
      end
    end
  end
end
