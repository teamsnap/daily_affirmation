module DailyAffirmation
  module Affirmations
    def self.included(descendant)
      descendant.extend(ClassMethods)
    end

    def initialize(object)
      self.object = object
    end

    def valid?
      validate[0]
    end

    def validate
      @validate ||= [
        affirmations.map(&:first).all?,
        affirmations.map(&:last).compact
      ]
    end

    def error_messages
      validate[1]
    end

    private

    attr_accessor :object

    def affirmations
      @affirmations ||= self.class.affirmations
        .map { |affirmation| affirm(affirmation) }
    end

    def affirm(affirmation)
      method = "affirm_#{affirmation[:type]}_of"
      attribute = affirmation[:attribute]
      args = affirmation.reject { |k, _| [:type, :attribute].include?(k) }
      if send(method, attribute, args)
        [true, nil]
      else
        [false, error_message_for(affirmation[:type], attribute, args)]
      end
    end

    def affirm_presence_of(attribute, _ = {})
      present?(attribute)
    end

    def affirm_absence_of(attribute, _ = {})
      blank?(attribute)
    end

    def affirm_inclusion_of(attribute, list: [])
      list.include?(object.send(attribute))
    end

    def affirm_exclusion_of(attribute, list: [])
      !list.include?(object.send(attribute))
    end

    def affirm_acceptance_of(attribute, _ = {})
      !!object.send(attribute)
    end

    def affirm_confirmation_of(attribute, _ = {})
      object.send(attribute) == object.send("#{attribute}_confirmation")
    end

    def affirm_format_of(attribute, regex: //)
      !!regex.match(object.send(attribute))
    end

    def affirm_length_of(attribute, range: 0..0)
      range.include?(object.send(attribute).size)
    end

    def affirm_numericality_of(attribute, _ = {})
      object.send(attribute).is_a?(Numeric)
    end

    def blank?(attribute)
      value = object.send(attribute)
      case value
      when String
        value !~ /[^[:space:]]/
      else
        value.respond_to?(:empty?) ? value.empty? : !value
      end
    end

    def present?(attribute)
      !blank?(attribute)
    end

    def error_message_for(type, attribute, opts = {})
      case type
      when :presence
        "#{attribute} can't be blank"
      when :absence
        "#{attribute} must be blank"
      when :inclusion
        "#{attribute} is not included in #{opts[:list]}"
      when :exclusion
        "#{attribute} is reserved"
      when :acceptance
        "#{attribute} must be accepted"
      when :confirmation
        "#{attribute} doesn't match confirmation"
      when :format
        "#{attribute} is invalid"
      when :length
        "#{attribute} is the wrong length (allowed #{opts[:range]})"
      when :numericality
        "#{attribute} is not a number"
      else
        "#{attribute} failed validation"
      end
    end

    module ClassMethods
      def affirms_presence_of(attribute)
        affirmations << {:attribute => attribute, :type => :presence}
      end

      def affirms_absence_of(attribute)
        affirmations << {:attribute => attribute, :type => :absence}
      end

      def affirms_inclusion_of(attribute, list: [])
        affirmations << {
          :attribute => attribute, :type => :inclusion, :list => list
        }
      end

      def affirms_acceptance_of(attribute)
        affirmations << {:attribute => attribute, :type => :acceptance}
      end

      def affirms_confirmation_of(attribute)
        affirmations << {:attribute => attribute, :type => :confirmation}
      end

      def affirms_exclusion_of(attribute, list: [])
        affirmations << {
          :attribute => attribute, :type => :exclusion, :list => list
        }
      end

      def affirms_format_of(attribute, regex: //)
        affirmations << {
          :attribute => attribute, :type => :format, :regex => regex
        }
      end

      def affirms_length_of(attribute, range: 0..0)
        affirmations << {
          :attribute => attribute, :type => :length, :range => range
        }
      end

      def affirms_numericality_of(attribute)
        affirmations << {:attribute => attribute, :type => :numericality}
      end

      def affirmations
        @affirmations ||= []
      end
    end
  end
end
