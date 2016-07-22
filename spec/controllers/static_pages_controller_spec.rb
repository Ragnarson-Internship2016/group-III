require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  before(:each) { get :about }
  render_views

  context "#about" do
    it "returns 200 HTTP code" do
      expect(response.status).to eql(200)
    end

    it "displays contact mail address" do
      expect(response.body).to include("contact@boardnroll.com")
    end
  end
end
