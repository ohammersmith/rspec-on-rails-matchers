begin
  require 'rubygems'
  require 'spec'
  
rescue LoadError
  puts "Please install rspec and mocha to run the tests."
  exit 1
end

$:.push(File.dirname(__FILE__) + '/../lib')

# TODO need this?
#Spec::Runner.configure do |config|
#  config.mock_with :mocha
#end