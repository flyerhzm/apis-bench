# This file is used by Rack-based servers to start the application.

require 'bundler/setup'

env = ENV["RACK_ENV"] || "development"
Bundler.require(:default, env.to_sym)
require './config/environment'
require_all "app/models/*"
require_all "app/apis/*"

class LeaderboardGrape < Grape::API
  mount LeaderboardsAPI
  mount UsersAPI
end

NewRelic::Agent.after_fork(:force_reconnect => true)
DependencyDetection.detect!
run LeaderboardGrape
