class ContactsController < ApplicationController

  get "/contacts" do
    if logged_in?
      @contacts = Contact.all
      erb :'/contacts/index'
    else
      redirect to "/users/login"
    end
  end

  get "/contacts/new" do
    if logged_in?
      erb :'/contacts/new'
    else
      redirect to "/users/login"
    end
  end

  post "/contacts" do
    @contact = Contact.new(:first_name => params[:first_name], :last_initial => params[:last_initial], :user_id => session[:user_id])
    if @contact.save
      redirect to "/contacts/#{@contact.id}"
    else
      erb :'/contacts/new'
    end
  end

  get "/contacts/:id" do
    @contact = Contact.find(params[:id])
    if logged_in? && (session[:user_id] == @contact.id)
      erb :'/contacts/show'
    else
      redirect to "/users/login"
    end
  end

  get "/contacts/:id/edit" do
    @contact = Contact.find(params[:id])
    if logged_in? && (session[:user_id] == @contact.id)
      erb :'/contacts/edit'
    else
      redirect to "/users/login"
    end
  end

  patch "/contact/:id" do
      @contact = Contact.find(params[:id])
      if logged_in? && (session[:user_id] == @contact.id)
        @contact.first_name = params[:first_name]
        @contact.last_initial = params[:last_initial]
        @contact.save
        redirect to "/contacts/#{@contact.id}"
      else
        redirect to "/users/login"
      end
  end

  delete "/articles/:id" do
    @contact = Contact.find(params[:id])
    if logged_in? && (session[:user_id] == @contact.id)
      @contact.delete
      redirect to "/contacts"
    else
      redirect to "/users/login"
    end
  end

end
