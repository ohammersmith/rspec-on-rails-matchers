if RAILS_ENV == 'test'
  require 'spec/rails/matchers/attributes'
  require 'spec/rails/matchers/observers'
  require 'spec/rails/matchers/associations'
  require 'spec/rails/matchers/validations'
  require 'spec/rails/matchers/views'
  require 'spec/rails/matchers/observers'
  require 'spec/rails/matchers/controller_filters'
end