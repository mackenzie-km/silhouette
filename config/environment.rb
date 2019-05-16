ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require_all 'app'

configure :development do
  set :database, "sqlite3:///database.db"
end

configure :production do
  db = URI.parse(ENV['postgresql-curved-74091'] || 'postgres://localhost/mydb')

ActiveRecord::Base.establish_connection(
  :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

end
