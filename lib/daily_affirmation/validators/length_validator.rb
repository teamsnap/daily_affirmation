require_relative "../validator"

module DailyAffirmation
  module Validators
    # This affirmation ensures an attribute's size is within the provided
    # :range option.
    #
    # @option opts [Range] :range the range the size of the attribute's value
    #   must fit in.
    class LengthValidator < Validator
      def valid?
        @valid ||= opts[:range].include?(value.size)
      end

      def error_message
        @error_message ||= i18n_error_message(
          :length,
          :default => "#{attribute} is the wrong length (allowed #{opts[:range]})"
        )
      end
    end
  end
end
