class UsersController < ApplicationController

  get "/users/new" do
    erb :'/users/new'
  end

  post "/users" do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.valid?
      @user.save
      session[:id] = @user.id
      @session = session
      erb :'contacts/new'
    else
      errors = @user.errors.messages
      flash[:message] = errors.collect {|key, value| "#{key.capitalize}: #{value.first}"}
      erb :'/users/new'
    end
  end

  get "/users/login" do
    erb :'/users/login'
  end

  post "/users/login" do
    @user = User.find_by(username: params[:username])
    if !!@user && !!@user.authenticate(params[:password])
      session[:id] = @user.id
      @session = session
      if @user.contacts.count == 0
        #flash[:message] = "User account created. Please fill out your first contact."
        erb :'/contacts/new'
      else
        erb :'/contacts'
      end
    else
      #flash[:message] = "We did not find any users with that username/password combination."
      erb :'/users/login'
    end
  end

  get "/users/logout" do
    session.clear
    redirect to "/"
  end
end
