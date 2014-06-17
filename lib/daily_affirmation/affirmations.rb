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

      process_validation = if args.include?(:if)
                             instance_eval(&args[:if])
                           else
                             true
                           end

      if process_validation
        validator = Object.const_get(
          "DailyAffirmation::Validators::#{type.to_s.capitalize}Validator"
        )
        results = validator.new(object, attribute, args).affirm

        if args.fetch(:inverse, false)
          [!results[0], results[1]]
        else
          results
        end
      else
        [true, nil]
      end
    end

    module ClassMethods
      def affirms_absence_of(attribute, opts = {})
        affirmations << {
          :attribute => attribute, :type => :absence
        }.merge(opts)
      end

      def affirms_acceptance_of(attribute, opts = {})
        affirmations << {
          :attribute => attribute, :type => :acceptance
        }.merge(opts)
      end

      def affirms_confirmation_of(attribute, opts = {})
        affirmations << {
          :attribute => attribute, :type => :confirmation
        }.merge(opts)
      end

      def affirms_exclusion_of(attribute, opts = {})
        opts[:list] ||= []
        affirmations << {
          :attribute => attribute, :type => :exclusion
        }.merge(opts)
      end

      def affirms_format_of(attribute, opts = {})
        opts[:regex] ||= //
        affirmations << {
          :attribute => attribute, :type => :format
        }.merge(opts)
      end

      def affirms_inclusion_of(attribute, opts = {})
        opts[:list] ||= []
        affirmations << {
          :attribute => attribute, :type => :inclusion
        }.merge(opts)
      end

      def affirms_length_of(attribute, opts = {})
        opts[:range] ||= 0..0
        affirmations << {
          :attribute => attribute, :type => :length
        }.merge(opts)
      end

      def affirms_numericality_of(attribute, opts = {})
        affirmations << {
          :attribute => attribute, :type => :numericality
        }.merge(opts)
      end

      def affirms_presence_of(attribute, opts = {})
        affirmations << {
          :attribute => attribute, :type => :presence
        }.merge(opts)
      end

      def affirms(attribute, opts = {})
        affirmations << {
          :attribute => attribute, :type => :custom
        }.merge(opts)
      end

      def affirmations
        @affirmations ||= []
      end
    end
  end
end
