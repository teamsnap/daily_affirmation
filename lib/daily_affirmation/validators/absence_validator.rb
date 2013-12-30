require_relative "../validator"
require_relative "presence_validator"

module DailyAffirmation
  module Validators
    class AbsenceValidator < Validator
      def valid?
        @valid ||= !PresenceValidator.new(object, attribute).valid?
      end

      def error_message
        @error_message ||= "#{attribute} must be blank"
      end
    end
  end
end
