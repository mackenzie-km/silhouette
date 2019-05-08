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
    binding.pry
    if @contact.save && (@contact.user_id == session[:user_id])
      redirect to "/contacts/#{@contact.slug}"
    else
      redirect to "/contacts/new"
    end
  end

  get "/contacts/:slug" do
    @contacts = Contact.find_by_slug(params[:slug])
    erb :'/contacts/show'
  end

  get "/contacts/:slug/edit" do
    @contact = Contact.find_by_slug(params[:slug])
    erb :'/contacts/edit'
  end

  patch "/contact/:slug" do
      @contact = Contact.find_by_slug(params[:slug])
      @contact.first_name = params[:first_name]
      @contact.last_initial = params[:last_initial]
      @contact.save
      redirect to "/contacts/#{@contact.slug}"
  end

  delete "/articles/:slug" do
    @contact = Contact.find_by_slug(params[:slug])
    @contact.delete
    redirect to "/contacts"
  end

end
