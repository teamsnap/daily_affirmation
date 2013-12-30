require_relative "../validator"
require_relative "presence_validator"

module DailyAffirmation
  module Validators
    class AbsenceValidator < Validator
      def valid?
        @valid ||= !PresenceValidator.new(object, attribute).valid?
      end

      def error_message
        @error_message ||= i18n_error_message(
          :absence, :default => "#{attribute} must be blank"
        )
      end
    end
  end
end
