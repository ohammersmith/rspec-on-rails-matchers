require File.dirname(__FILE__) + '/spec_helper'

class Model < ActiveRecord::Base
  attr_accessor :name
  
  validates_presence_of :name
  
  # Prevent ActiveRecord initialisation, as we don't have a database
  def initialize; end
  
  # Fake some ActiveRecord behaviour
  def method_missing(symbol, *params)
    send $1 if (symbol.to_s =~ /(.*)_before_type_cast$/)
  end
  def transfer_attributes(params)
    params.each do | name, value |
      self.send("#{name}=", value) if self.respond_to?("#{name}=")
    end
  end
end

describe "'validate_presence_of' matcher" do
  it "should have the label 'model to validate the presence of <attr>'" do
    validate_presence_of(:foo).description.should == "model to validate the presence of foo"
  end
  
  it "should match for an instance when the validation is present" do
    Model.new.should validate_presence_of(:name)
  end
  
  it "should not match for an instance when the association is not present" do
    Model.new.should_not validate_presence_of(:foo)
  end
end