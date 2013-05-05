require 'bundler/setup'
Bundler.require(:default, :test)

set :environment, :test
require_relative '../config/environment'
require_all 'spec/factories/*'
require_all 'app/models/*'
require_all 'app/controllers/*'

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.order = "random"

  config.after do
    DatabaseCleaner.clean
  end
end
