env = ENV['RACK_ENV'] || "development"
config = YAML::load(File.open('config/database.yml'))[env]
ActiveRecord::Base.establish_connection(config)
