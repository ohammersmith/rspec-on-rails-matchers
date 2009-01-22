module Spec
  module Rails
    module Matchers
      def use_method_for_callback(method, callback)
        return simple_matcher("model to use method #{method} for callback #{callback}") do |model_class|
          model_class.send("#{callback.to_s}_callback_chain").find(method)
        end
      end
    end
  end
end