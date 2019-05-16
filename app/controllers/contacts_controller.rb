class ContactsController < ApplicationController

  get "/contacts" do
    if logged_in?
      @contacts = Contact.where("user_id = ?", current_user.id)
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
    details = Fact.normalize(params[:facts])

    if @contact.save
      details.each do |fact|
        fact_object = Fact.new(:topic => fact[0], :information => fact[1], :contact_id => @contact.id)
        fact_object.save
        @contact.facts << fact_object
      end
      redirect to "/contacts/#{@contact.id}"
    else
      errors = @contact.errors.messages
      flash[:message] = errors.collect {|key, value| "#{key.capitalize}: #{value.first}"}
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
      details = Fact.normalize(params[:facts])

      if right_user?(@contact)
        @contact.first_name = params[:first_name] if params[:first_name] != ""
        @contact.last_initial = params[:last_initial] if params[:last_initial] != ""
        @contact.photo = params[:photo] if params[:photo] != ""

        details.each do |fact|
          found_fact = Fact.where(:topic => fact[0], :contact_id => @contact.id).first_or_create
          found_fact.update(:information => fact[1])
          @contact.facts << found_fact if found_fact.save
        end

        @contact.save
        redirect to "/contacts/#{@contact.id}"
      else
        redirect to "/users/login"
      end
  end

  delete "/contacts/:id" do
    @contact = Contact.find(params[:id])
    if right_user?(@contact)
      @contact.destroy
      redirect to "/contacts"
    else
      redirect to "/users/login"
    end
  end

end
