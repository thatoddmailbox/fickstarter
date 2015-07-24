require_relative "../../config/environment"

require_relative "../models/user"
require_relative "../models/project"
require_relative "../models/donation"

class ApplicationController < Sinatra::Base
  
  enable :sessions
  set :session_secret, 'fickstarter is awesome and this is a cookie secret'
  
  set :views, "app/views"
  set :public_folder, "public"
  
  get "/" do
    erb :index, :layout => :layout
  end
  
  get "/login" do
    erb :login, :layout => :layout
  end
  
  post '/login' do
    @user = User.find_by_username(params[:username])
    if @user.password == params[:password]
      redirect to("/projects")
    else 
      return "incorrect password"
    end
  end
  
  get "/signup" do
    erb :signup, :layout => :layout
  end
  
  post "/signup" do
    @user = User.new(:username => params[:username], :password => params[:password])
    @user.save
    redirect to("/projects")
  end
  
  get "/projects" do
    erb :projects, :layout => :layout
  end
  
  get "/info/:project_id" do
    @project = Project.find(params[:project_id])
    erb :info, :layout => :layout
  end
end