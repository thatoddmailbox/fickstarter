require_relative "../../config/environment"

require_relative "../models/user"
require_relative "../models/project"
require_relative "../models/donation"

class ApplicationController < Sinatra::Base
  
  enable :sessions
  set :session_secret, 'fickstarter is awesome and this is a cookie secret'
  
  set :views, "app/views"
  set :public_folder, "public"
  
  before do
    if session[:logged_in]
      @user = User.find(session[:user_id])
      @username = @user.username
    end
  end
  
  get "/" do
    erb :index, :layout => :layout
  end
  
  get "/login" do
    erb :login, :layout => :layout
  end
  
  post '/login' do
    @user = User.find_by_username(params[:username])
    session[:logged_in] = true
    session[:user_id] = @user.id
    erb :projects, :layout => :layout
  end
  
  get "/signup" do
    erb :signup, :layout => :layout
  end
  
  post "/signup" do
    @user = User.new(:username => params[:username], :password => params[:password])
    @user.save
    session[:logged_in] = true
    session[:user_id] = @user.id
    erb :projects, :layout => :layout
  end
  
  get "/logout" do    
    session[:logged_in] = false
    session[:user_id] = -1
    redirect to("/")
  end
  
  get "/projects" do
    erb :projects, :layout => :layout
  end
  
  get "/info/:project_id" do
    @project = Project.find(params[:project_id])
    erb :info, :layout => :layout
    
  end
  
  get "/create" do
    erb :create, :layout => :layout
  end
  
  post "/create" do
    @project = Project.new(:name => params[:name], :description => params[:description], :target => params[:target], :end_date => params[:end_date])
    @project.save
    
    redirect to("/info/" + @project.id.to_s)
  end
  
  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end
  
  post "/donation" do
    @donation = Donation.new(:amount => params[:amount])
    @donation.user = @user
    @donation.project_id = params[:project]
    @donation.save
    erb :donation
  end
end