module Spec
  module Rails
    module Matchers
      class ControllerActionFacade
        attr_reader :action_name
        
        def initialize(controller_instance, action_name)
          @controller_instance = controller_instance
          @action_name = action_name.to_s
        end
        
        def method_missing(meth, *args)
          @controller_instance.send(meth, *args)
        end
      end
      
      def use_filter(kind, name, options = {})
        return simple_matcher("controller to use before_filter #{name}") do |controller|
          raise ArgumentError unless options.has_key?(:for)
          # controller = controller.class if controller.is_a? ActionController::Base
          potential_filters = controller.class.filter_chain.select do |filter| 
            filter.send("#{kind.to_s}?".to_sym) && filter.method == name.to_sym
          end
          return false if potential_filters.empty?
          potential_filters.first.send(:should_run_callback?, ControllerActionFacade.new(controller, options[:for]))
        end
      end
      
      def use_before_filter(name, options = {})
        use_filter(:before, name, options)
      end
      
      def use_after_filter(name, options = {})
        use_filter(:after, name, options)
      end
      
      def use_around_filter(name, options = {})
        use_filter(:around, name, options)
      end
    end
  end
end