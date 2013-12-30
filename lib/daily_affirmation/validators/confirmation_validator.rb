require_relative "../validator"

module DailyAffirmation
  module Validators
    class ConfirmationValidator < Validator
      def valid?
        @valid ||= value == object.send("#{attribute}_confirmation")
      end

      def error_message
        @error_message ||= i18n_error_message(
          :confirmation, :default => "#{attribute} doesn't match confirmation"
        )
      end
    end
  end
end
