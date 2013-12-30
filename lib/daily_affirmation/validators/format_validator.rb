require_relative "../validator"

module DailyAffirmation
  module Validators
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
