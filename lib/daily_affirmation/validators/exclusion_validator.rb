require_relative "../validator"
require_relative "inclusion_validator"

module DailyAffirmation
  module Validators
    class ExclusionValidator < Validator
      def valid?
        @valid ||= !InclusionValidator.new(object, attribute, opts).valid?
      end

      def error_message
        @error_message ||= "#{attribute} is reserved"
      end
    end
  end
end
