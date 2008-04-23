require File.dirname(__FILE__) + '/spec_helper'

class Model < ActiveRecord::Base
  belongs_to :parent
  has_many :children
  def initialize; end # prevent actual AR initialisation
end

describe "Matcher for 'belongs_to' association" do
  it "should have the label 'model to belong to <association>'" do
    belong_to(:foo).description.should == "model to belong to foo"
  end
  
  it "should match for a class when the association is present" do
    Model.should belong_to(:parent)
  end
  
  it "should match for an instance when the association is present" do
    Model.new.should belong_to(:parent)
  end

  it "should not match for a class when the association is not present" do
    Model.should_not belong_to(:foo)
  end
  
  it "should not match for an instance when the association is not present" do
    Model.new.should_not belong_to(:foo)
  end
end

describe "Matcher for 'has_many' association" do
  it "should have the label 'model to have many <association>'" do
    have_many(:foos).description.should == "model to have many foos"
  end
  
  it "should match for a class when the association is present" do
    Model.should have_many(:children)
  end
  
  it "should match for an instance when the association is present" do
    Model.new.should have_many(:children)
  end

  it "should not match for a class when the association is not present" do
    Model.should_not have_many(:foos)
  end
  
  it "should not match for an instance when the association is not present" do
    Model.new.should_not have_many(:foos)
  end
end