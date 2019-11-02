require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :root, File.dirname(__FILE__)
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, ENV['SESSION_SECRET']
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def right_user?(contact)
      !!(logged_in? && (session[:user_id] == contact.user_id))
    end

    def redirect_if_wrong_user(contact)
      if !right_user?(contact)
        redirect to "/users/login"
      end
    end

    def redirect_if_logged_out
      if !logged_in?
        redirect to "/users/login"
      end
    end
  end
end
