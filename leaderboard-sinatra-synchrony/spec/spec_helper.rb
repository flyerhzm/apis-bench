require 'bundler/setup'
Bundler.require(:default, :test)

set :environment, :test
set :database, "mysql2://root@localhost/api_bench_test"
require_all 'spec/factories/*'
require_all 'app/models/*'
require_all 'app/apis/*'

Sinatra::Synchrony.patch_tests!

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.order = "random"

  config.after do
    DatabaseCleaner.clean
  end
end
