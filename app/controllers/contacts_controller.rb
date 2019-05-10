class ContactsController < ApplicationController

  get "/contacts" do
    if logged_in?
      @contacts = Contact.order(first_name: :asc)
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
    @contact = Contact.new(:first_name => params[:first_name].capitalize, :last_initial => params[:last_initial].capitalize, :user_id => session[:user_id], :photo => params[:photo])
    if @contact.save
      details = Fact.normalize(params[:facts])
      details.each do |fact|
        fact_object = Fact.new(:topic => fact[0], :information => fact[1], :contact_id => @contact.id)
        @contact.facts << fact_object
      end
      redirect to "/contacts/#{@contact.id}"
    else
      erb :'/contacts/new'
    end
  end

  get "/contacts/:id" do
    @contact = Contact.find(params[:id])
    if right_user?(@contact)
      erb :'/contacts/show'
    else
      redirect to "/users/login"
    end
  end

  get "/contacts/:id/edit" do
    @contact = Contact.find(params[:id])
    if right_user?(@contact)
      erb :'/contacts/edit'
    else
      redirect to "/users/login"
    end
  end

  patch "/contacts/:id" do
      @contact = Contact.find(params[:id])
      if right_user?(@contact)
        if params[:first_name] != "" then @contact.first_name = params[:first_name] end
        if params[:last_initial] != "" then @contact.last_initial = params[:last_initial] end

        details = Fact.normalize(params[:facts])
        details.each do |fact|
          fact = Fact.find_by(:topic => fact[0], :contact_id => @contact.id)
            if fact != nil
              Fact.update(fact.id, :information => fact[1])
              fact.save
            else
              fact_object = Fact.new(:topic => fact[0], :information => fact[1], :contact_id => @contact.id)
              fact_object.save
              @contact.facts << fact_object
            end
        end
        redirect to "/contacts/#{@contact.id}"
      else
        redirect to "/users/login"
      end
  end

  delete "/contacts/:id" do
    @contact = Contact.find(params[:id])
    if right_user?
      @contact.delete
      redirect to "/contacts"
    else
      redirect to "/users/login"
    end
  end

end
