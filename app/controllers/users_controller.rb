class UsersController < ApplicationController
  get "/users/new" do
    erb :'/users/new'
  end

  post "/users" do
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    redirect to "/contacts/new"
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
