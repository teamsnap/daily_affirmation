require_relative "../validator"

module DailyAffirmation
  module Validators
    # This affirmation ensures an attribute's size is within the provided
    # :range option.
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
