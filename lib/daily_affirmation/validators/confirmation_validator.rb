require_relative "../validator"

module DailyAffirmation
  module Validators
    # This affirmation ensures a related attribute *_confirmation has the same
    # value.
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
