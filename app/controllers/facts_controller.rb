class FactsController < ApplicationController
    get "/facts/:id/delete" do
      @fact = Fact.find(params[:id])
      @fact.destroy
      redirect to "/contacts/#{@fact.contact_id}/edit"
    end
end
