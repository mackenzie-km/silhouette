require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, 'secret'
  end

  get "/" do
    erb :index
  end

  get "/" do
    erb :about
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
  end
end
