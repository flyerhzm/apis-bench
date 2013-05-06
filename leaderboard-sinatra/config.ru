# This file is used by Rack-based servers to start the application.

require 'bundler/setup'

env = ENV["RACK_ENV"] || "development"
Bundler.require(:default, env.to_sym)
require_all "app/models/*"
require_all "app/controllers/*"

use ActiveRecord::ConnectionAdapters::ConnectionManagement
run LeaderboardsApp
