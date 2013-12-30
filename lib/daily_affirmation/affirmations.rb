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
      type = affirmation[:type]
      attribute = affirmation[:attribute]
      args = affirmation.reject { |k, _| [:type, :attribute].include?(k) }

      validator = Object.const_get(
        "DailyAffirmation::Validators::#{type.to_s.capitalize}Validator"
      )
      validator.new(object, attribute, args).affirm
    end

    module ClassMethods
      def affirms_absence_of(attribute)
        affirmations << {:attribute => attribute, :type => :absence}
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

      def affirms_inclusion_of(attribute, list: [])
        affirmations << {
          :attribute => attribute, :type => :inclusion, :list => list
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

      def affirms_presence_of(attribute)
        affirmations << {:attribute => attribute, :type => :presence}
      end

      def affirmations
        @affirmations ||= []
      end
    end
  end
end
