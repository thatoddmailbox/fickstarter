require_relative "../../config/environment"

require_relative "../models/user"

class ApplicationController < Sinatra::Base
  
  enable :sessions
  set :session_secret, 'fickstarter is awesome and this is a cookie secret'
  
  set :views, "app/views"
  set :public_folder, "public"
  
  
end