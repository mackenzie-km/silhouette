class UsersController < ApplicationController

  get "/users/new" do
    if logged_in?
      redirect to '/contacts'
    else
      erb :'/users/new'
    end
  end

  post "/users" do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      flash[:message] = "Please make your first contact profile."
      redirect to '/contacts/new'
      # use redirect to change url and move to new contacts page
    else
      errors = @user.errors.messages
      flash[:message] = errors.collect {|key, value| "#{key.capitalize}: #{value.first}"}
      erb :'/users/new'
    end
  end

  get "/users/login" do
    if logged_in?
      redirect to '/contacts'
    else
      erb :'/users/login'
    end
  end

  post "/users/login" do
    @user = User.find_by(username: params[:username])
    if !!@user && !!@user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/contacts'
    else
      flash[:message] = "We did not find any users with that username/password combination."
      erb :'/users/login'
    end
  end

  get "/users/logout" do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/'
    end
  end
end
