class BaseAPI < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), "../views")
end
