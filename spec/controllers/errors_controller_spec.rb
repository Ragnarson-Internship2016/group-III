require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe "GET #not_found" do
    it "returns proper http status" do
      get :not_found
      expect(response).to have_http_status(404)
    end
  end

  describe "GET #validation_error" do
    it "returns proper http status" do
      get :validation_error
      expect(response).to have_http_status(422)
    end
  end
end
