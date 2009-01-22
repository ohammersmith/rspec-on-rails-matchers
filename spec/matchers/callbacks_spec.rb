require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
require 'spec/rails/matchers/callbacks'
require 'active_support'

class CallbackMatchers
  include Spec::Rails::Matchers
  include Spec::Matchers
end

describe "ActiveRecord callback matchers" do
  before(:each) do
    @klass = Class.new
    @klass.class_eval do 
      include ActiveSupport::Callbacks
      define_callbacks :before_something, :after_that_thing
    end
    
    @matchers = CallbackMatchers.new
  end
  
  describe "method-using callbacks" do
    before(:each) do
      @klass.class_eval do
        before_something :do_gubbins
        def do_gubbins
        end
      end
    end
    
    it "should report that a class is using given_method for given_callback" do
      @klass.should @matchers.use_method_for_callback(:do_gubbins, :before_something)
    end
    
    it "should report that a class is NOT using given_method for given_callback" do
      @klass.should_not @matchers.use_method_for_callback(:do_the_wrong_gubbins, :before_something)
    end
  end
end