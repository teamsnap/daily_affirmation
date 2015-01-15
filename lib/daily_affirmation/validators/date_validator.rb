require_relative "../validator"

module DailyAffirmation
  module Validators
    # This affirmation ensures an attribute is a date and if a :before or
    # :after option is given, that the attribute is before or after the
    # selected date.
    class DateValidator < Validator
      class NullDateLike
        def <(val); true; end
        def >(val); true; end
      end

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

      def before
        @before ||= -> {
          val = opts.fetch(:before, NullDateLike.new)
          val.respond_to?(:call) ? val.call : val
        }.call
      end

      def before?
        before > value
      end

      def after
        @after ||= -> {
          val = opts.fetch(:after, NullDateLike.new)
          val.respond_to?(:call) ? val.call : val
        }.call
      end

      def after?
        after < value
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
