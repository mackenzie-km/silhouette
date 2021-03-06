class ContactsController < ApplicationController

  get "/contacts" do
    redirect_if_logged_out
    @contacts = current_user.contacts.order(:first_name)
    erb :'/contacts/index'
  end

  get "/contacts/new" do
    redirect_if_logged_out
    erb :'/contacts/new'
  end

  post "/contacts" do
    @contact = Contact.new(:first_name => params[:first_name].capitalize, :last_initial => params[:last_initial].capitalize, :user_id => session[:user_id], :photo => params[:photo])
    details = Fact.normalize(params[:facts])

    if @contact.save
      details.each do |fact|
        @contact.facts.create(:topic => fact[0], :information => fact[1], :contact_id => @contact.id)
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
    redirect_if_wrong_user(@contact)
    erb :'/contacts/show'
  end

  get "/contacts/:id/edit" do
    @contact = Contact.find(params[:id])
    redirect_if_wrong_user(@contact)
    erb :'/contacts/edit'
  end

  patch "/contacts/:id" do
      @contact = Contact.find(params[:id])
      details = Fact.normalize(params[:facts])

      redirect_if_wrong_user(@contact)

      @contact.first_name = params[:first_name] if params[:first_name] != ""
      @contact.last_initial = params[:last_initial] if params[:last_initial] != ""
      @contact.photo = params[:photo] if params[:photo] != ""

      details.each do |fact|
        found_fact = Fact.where(:topic => fact[0], :contact_id => @contact.id).first_or_create
        found_fact.update(:information => fact[1], :contact_id => @contact.id)
        found_fact.save
      end

      @contact.save
      redirect to "/contacts/#{@contact.id}"
  end

  delete "/contacts/:id" do
    @contact = Contact.find(params[:id])
    redirect_if_wrong_user(@contact)
    @contact.destroy
    redirect to "/contacts"
  end

end
