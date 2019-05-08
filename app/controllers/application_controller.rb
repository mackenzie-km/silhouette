require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get "/" do
    erb :index
  end

  helpers do
    def login_now
      session[:user_id] = @user.id
      @user.username
    end
  end
end


# blanks = ((params[:username] == "") || (params[:email] == "") || (params[:password] == ""))
# nils = ((params[:username] == nil) || (params[:email] == nil) || (params[:password] == nil))
# unique = ((User.find_by(username: params[:username]) == nil) || (User.find_by(email: params[:email]) == nil))
#
# if (blanks == false) && (nils == false) && (unique == true)
#   true
# else
#   false
# end
