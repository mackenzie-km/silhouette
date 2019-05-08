class ContactsController < ApplicationController
  get "/contacts" do
    @contacts = Contact.all
    erb :'/contacts/index'
  end

  get "/contacts/new" do
    erb :'/contacts/new'
  end

  post "/contacts" do
    @contact = Contact.create(:first_name => params[:first_name], :last_initial => params[:last_initial], :user_id => session[:user_id])
    redirect to "/contacts/#{@contact.id}"
  end

  get "/contacts/:id" do
    @contacts = Contact.find(params[:id])
    erb :'/contacts/show'
  end

  get "/contacts/:id/edit" do
    @contact = Contact.find(params[:id])
    erb :'/contacts/edit'
  end

  patch "/contact/:id" do
      @contact = Contact.find(params[:id])
      @contact.first_name = params[:first_name]
      @contact.last_initial = params[:last_initial]
      @contact.save
      redirect to "/contacts/#{@contact.id}"
  end

  delete "/articles/:id" do
    @contact = Contact.find(params[:id])
    @contact.delete
    redirect to "/contacts" 
  end

end
