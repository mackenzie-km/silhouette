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
    @contact = Contact.new(:first_name => params[:first_name].capitalize, :last_initial => params[:last_initial].capitalize, :user_id => session[:user_id])
    if @contact.save
      details = Fact.normalize(params[:facts])
      details.each do |fact|
        fact_object = Fact.new(:topic => fact[0], :information => fact[1], :contact_id => @contact.id)
        if fact_object.save
          @contact.facts << fact_object
        else
          flash[:message] = "Invalid format. Please try again."
        end
      end
      redirect to "/contacts/#{@contact.id}"
    else
      erb :'/contacts/new'
    end
  end

  get "/contacts/:id" do
    @contact = Contact.find(params[:id])
    if logged_in? && (session[:user_id] == @contact.user_id)
      erb :'/contacts/show'
    else
      redirect to "/users/login"
    end
  end

  get "/contacts/:id/edit" do
    @contact = Contact.find(params[:id])
    if logged_in? && (session[:user_id] == @contact.user_id)
      erb :'/contacts/edit'
    else
      redirect to "/users/login"
    end
  end

  patch "/contacts/:id" do
      @contact = Contact.find(params[:id])
      if logged_in? && (session[:user_id] == @contact.user_id)
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
    if logged_in? && (session[:user_id] == @contact.user_id)
      @contact.delete
      redirect to "/contacts"
    else
      redirect to "/users/login"
    end
  end

end
