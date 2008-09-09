module Spec
  module Rails
    module Matchers
      def allow_mass_assignment_of(*attributes)
        attributes = [attributes] unless attributes.is_a?(Array)
        AllowMassAssignmentOf.new(attributes)
      end
      
      class AllowMassAssignmentOf
        attr_accessor :description
        
        def initialize(attributes)
          @description = "allow mass assignment of #{attributes.join(', ')}"
          @expected = attributes.map { |a| a.to_s }
        end
    
        def matches?(target)    
          @accesible = []
          attributes = target.attributes.keys
          attributes.each do |attribute|
            target.attributes = {attribute => 'kind_of_matcher_parameter'}
            if target[attribute] == 'kind_of_matcher_parameter'
              @accesible << attribute unless @expected.include?(attribute)
              @expected = @expected - [attribute]              
            end
          end
          @expected.empty? && @accesible.empty?
        end
    
        def failure_message
          msg = ''
          msg += "expected #{@expected.join(', ')} to be accesible. " unless @expected.empty?
          msg += "expected #{@accesible.join(', ')} to be protected." unless @accesible.empty?
          msg
        end
    
        def negative_failure_message
          msg = ''
          msg += "expected #{@expected.join(', ')} to be protected. " unless @expected.empty?
          msg += "expected #{@accesible.join(', ')} to be accesible." unless @accesible.empty?
          msg
        end
      end
    end
  end
end