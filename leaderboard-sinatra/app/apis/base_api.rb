class BaseAPI < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, File.join(File.dirname(__FILE__), "../views")
end
