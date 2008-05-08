require File.dirname(__FILE__) + '/spec_helper'

class PseudoActiveRecord < ActiveRecord::Base
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
  def inspect
    "#{self.class} #{object_id}"
  end
end

describe "'validate_presence_of' matcher" do
  class PresenceModel < PseudoActiveRecord
    attr_accessor :name
    validates_presence_of :name
  end

  before do
    @model = PresenceModel.new
  end
  
  it "should have the label 'model to validate the presence of <attr>'" do
    validate_presence_of(:foo).description.should == "model to validate the presence of foo"
  end
  
  it "should match for an instance when the validation is present" do
    @model.should validate_presence_of(:name)
  end
  
  it "should not match for an instance when the validation is not present" do
    @model.should_not validate_presence_of(:foo)
  end
end

describe "'validate_length_of' matcher" do
  describe "using 'within'" do
    class LengthWithinModel < PseudoActiveRecord
      attr_accessor :name
      validates_length_of :name, :within => 2...20
    end

    before do
      @model = LengthWithinModel.new
    end

    it "should have the label 'model to validate the length of <attr> within <min> and <max>'" do
      validate_length_of(:foo, :within => 1...2).description.should == "model to validate the length of foo within 1 and 2"
    end
  
    it "should match for an instance when the validation is present" do
      @model.should validate_length_of(:name, :within => 2...20)
    end
  
    it "should not match for an instance when the minimum is too low" do
      @model.should_not validate_length_of(:name, :within => 3...20)
    end
  
    it "should not match for an instance when the minimum is too high" do
      @model.should_not validate_length_of(:name, :within => 1...20)
    end
  
    it "should not match for an instance when the validation is not present" do
      @model.should_not validate_length_of(:foo, :within => 1...2)
    end
  end

  describe "using 'is'" do
    class LengthIsModel < PseudoActiveRecord
      attr_accessor :name
      validates_length_of :name, :is => 4
    end

    before do
      @model = LengthIsModel.new
    end

    it "should have the label 'model to validate the length of <attr> within <length> and <length>'" do
      validate_length_of(:foo, :is => 3).description.should == "model to validate the length of foo within 3 and 3"
    end
  
    it "should match for an instance when the validation is present" do
      @model.should validate_length_of(:name, :is => 4)
    end
  
    it "should not match for an instance when the validation is not present" do
      @model.should_not validate_length_of(:foo, :is => 4)
    end
  end
end