class ContactsController < ApplicationController

  get "/contacts" do
    if logged_in?
      @contacts = Contact.find_by(user_id: session[:id])
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
    @contact = Contact.new(:first_name => params[:first_name], :last_initial => params[:last_initial], :user_id => session[:id])
    if @contact.save
      erb :"/contacts/show"
    else
      erb :'/contacts/new'
    end
  end

  get "/contacts/:slug" do
    @contact = Contact.find_by_slug(params[:slug])
    if logged_in? && (session[:id] == @contact.id)
      erb :'/contacts/show'
    else
      redirect to "/users/login"
    end
  end

  get "/contacts/:slug/edit" do
    @contact = Contact.find_by_slug(params[:slug])
    if logged_in? && (session[:id] == @contact.id)
      erb :'/contacts/edit'
    else
      redirect to "/users/login"
    end
  end

  patch "/contact/:slug" do
      @contact = Contact.find_by_slug(params[:slug])
      if logged_in? && (session[:id] == @contact.id)
        @contact.first_name = params[:first_name]
        @contact.last_initial = params[:last_initial]
        @contact.save
        redirect to "/contacts/#{@contact.slug}"
      else
        redirect to "/users/login"
      end
  end

  delete "/articles/:slug" do
    @contact = Contact.find_by_slug(params[:slug])
    if logged_in? && (session[:id] == @contact.id)
      @contact.delete
      redirect to "/contacts"
    else
      redirect to "/users/login"
    end
  end

end
