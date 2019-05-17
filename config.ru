require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

<<<<<<< HEAD
=======
set :public_folder, File.dirname(__FILE__) + '/public'

>>>>>>> parent of f88ba6b... no asset bug patch
use Rack::MethodOverride
use UsersController
use ContactsController
use FactsController
run ApplicationController
