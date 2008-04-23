require File.dirname(__FILE__) + '/spec_helper'

class Model < ActiveRecord::Base
  belongs_to :another_model
  def initialize; end # prevent actual AR initialisation
end

describe "Matcher for 'belongs_to' association" do
  it "should match when a class belongs to the specified model" do
    Model.should belong_to(:another_model)
  end
  
  it "should match when an instance belongs to the specified model" do
    Model.new.should belong_to(:another_model)
  end

  it "should not match when a class does not belong to the specified model" do
    Model.should_not belong_to(:different_model)
  end
  
  it "should not match when an instance does not belong to the specified model" do
    Model.new.should_not belong_to(:different_model)
  end
end