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
      send(method, attribute, args)
    end

    def affirm_presence_of(attribute, _ = {})
      if present?(attribute)
        [true, nil]
      else
        [false, "#{attribute} can't be blank"]
      end
    end

    def affirm_absence_of(attribute, _ = {})
      if present?(attribute)
        [false, "#{attribute} must be blank"]
      else
        [true, nil]
      end
    end

    def affirm_inclusion_of(attribute, list: [])
      if list.include?(object.send(attribute))
        [true, nil]
      else
        [false, "#{attribute} is not included in #{list}"]
      end
    end

    def affirm_exclusion_of(attribute, list: [])
      if list.include?(object.send(attribute))
        [false, "#{attribute} is reserved"]
      else
        [true, nil]
      end
    end

    def affirm_acceptance_of(attribute, _ = {})
      if object.send(attribute)
        [true, nil]
      else
        [false, "#{attribute} must be accepted"]
      end
    end

    def affirm_confirmation_of(attribute, _ = {})
      if object.send(attribute) == object.send("#{attribute}_confirmation")
        [true, nil]
      else
        [false, "#{attribute} doesn't match confirmation"]
      end
    end

    def affirm_format_of(attribute, regex: //)
      if regex.match(object.send(attribute))
        [true, nil]
      else
        [false, "#{attribute} is invalid"]
      end
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

      def affirmations
        @affirmations ||= []
      end
    end
  end
end
