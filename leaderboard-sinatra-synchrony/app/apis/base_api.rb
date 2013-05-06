class BaseAPI < Sinatra::Base
  register Sinatra::Synchrony
  set :views, File.join(File.dirname(__FILE__), "../views")
end
