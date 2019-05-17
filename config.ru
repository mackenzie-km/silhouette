require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

set :public_folder, File.dirname(__FILE__) + '/public'

use Rack::MethodOverride
use UsersController
use ContactsController
use FactsController
run ApplicationController
