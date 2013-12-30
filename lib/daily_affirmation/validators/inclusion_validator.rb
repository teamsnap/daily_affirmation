require_relative "../validator"

module DailyAffirmation
  module Validators
    class InclusionValidator < Validator
      def valid?
        @valid ||= opts[:list].include?(value)
      end

      def error_message
        @error_message ||= "#{attribute} is not included in #{opts[:list]}"
      end
    end
  end
end