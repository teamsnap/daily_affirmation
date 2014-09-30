require_relative "../validator"

module DailyAffirmation
  module Validators
    class DateValidator < Validator
      def valid?
        @valid ||= parseable? && before? && after?
      end

      def error_message
        @error_message ||= i18n_error_message(
          :format, :default => "#{attribute} is not a valid #{as}"
        )
      end

      private

      def parseable?
        value.is_a?(klass) || !!klass.parse(value)
      rescue ArgumentError
        false
      end

      def as
        opts.fetch(:as, :date)
      end

      def before?
        if opts[:before]
          value < opts[:before]
        else
          true
        end
      end

      def after?
        if opts[:after]
          value > opts[:after]
        else
          true
        end
      end

      def klass
        case as
        when :date
          Date
        when :datetime
          DateTime
        when :time
          Time
        else
          raise OptionError,
            "Invalid value for `:as`: #{opts[:as]}. Valid options are :date, :datetime and :time."
        end
      end
    end
  end
end
