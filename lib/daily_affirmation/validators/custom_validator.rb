require_relative "../validator"

module DailyAffirmation
  module Validators
    class CustomValidator < Validator
      def valid?
        @valid ||= opts[:proc].call(object)
      end

      def error_message
        @error_message ||= i18n_error_message(
          :custom, :default => "#{attribute} is invalid"
        )
      end
    end
  end
end