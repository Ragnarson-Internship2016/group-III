require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user){ FactoryGirl.create(:user) }

  describe "GET /user_edit" do

    let(:user_new_parameters) do
      { :name => "new name", :surname => "new surname", :city => "new city" }
    end

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    it "checks if update changes parameters" do
      put :update, params: { id: user.id, user: user_new_parameters }
      user.reload
      expect(user.name).to eql user_new_parameters[:name]
      expect(user.surname).to eql user_new_parameters[:surname]
      expect(user.city).to eql user_new_parameters[:city]
    end

    it "check if redirects to url" do
      put :update, params: { id: user.id, user: user_new_parameters }
      expect(response).to redirect_to root_url
    end
  end
end
