require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::Static, :urls => ['/images', '/css'], :root => 'public'

use Rack::MethodOverride
use UsersController
use ContactsController
use FactsController
run ApplicationController
