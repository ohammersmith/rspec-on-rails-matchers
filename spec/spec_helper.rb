require 'spec'
require 'activerecord'

Dir.glob(File.dirname(__FILE__) + '/../lib/spec/rails/matchers/*.rb').each do |f|
  require f
end

include Spec::Rails::Matchers