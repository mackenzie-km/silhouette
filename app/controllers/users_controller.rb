class UsersController < ApplicationController

  get "/users/new" do
    erb :'/users/new'
  end

  post "/users" do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.valid?
      @user.save
      login_now
      binding.pry
      redirect to "/contacts/new"
    else
      redirect to "/users/new"
    end
  end

  get "/users/login" do
    erb :'/users/login'
  end

  post "/users/login" do
    @user = User.find(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/contacts"
    else
      redirect to "/users/login"
    end
  end
end
