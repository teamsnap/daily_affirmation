require_relative "../validator"

module DailyAffirmation
  module Validators
    # This affirmation ensures an attribute matches the provided :regex option.
    class FormatValidator < Validator
      def valid?
        @valid ||= !!opts[:regex].match(value)
      end

      def error_message
        @error_message ||= i18n_error_message(
          :format, :default => "#{attribute} is invalid"
        )
      end
    end
  end
end
