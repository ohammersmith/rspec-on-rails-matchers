module Spec
  module Rails
    module Matchers
      class ControllerActionFacade
        attr_reader :action
        
        def initialize(controller_instance, action)
          @controller_instance = controller_instance
          @action = action
        end
        
        def method_missing(meth, *args)
          @controller_instance.send(meth, *args)
        end
      end
      
      def use_before_filter(filter_name, options = {})
        return simple_matcher("controller to use before_filter #{filter_name}") do |controller|
          raise ArgumentError unless options.has_key(:for)
          # controller = controller.class if controller.is_a? ActionController::Base
          potential_filters = controller.class.filter_chain.select do |filter| 
            filter.before? && filter.method == filter_name.to_sym
          end
          return false if potential_filters.empty?
          potential_filters.first.should_run_callback?(ControllerActionFacade.new(controller, options[:for]))
        end
      end
    end
  end
end

def should_not_skip?(controller)
  if options[:skip]
    !included_in_action?(controller, options[:skip])
  else
    true
  end
end

def included_in_action?(controller, options)
  if options[:only]
    Array(options[:only]).map(&:to_s).include?(controller.action_name)
  elsif options[:except]
    !Array(options[:except]).map(&:to_s).include?(controller.action_name)
  else
    true
  end
