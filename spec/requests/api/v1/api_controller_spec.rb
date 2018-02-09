class AnyController < ApiController
  skip_before_action :require_login, :set_product
  def show
    return_the nil
  end
end


describe "Api (v1)" do

  before(:all) do
    Rails.application.routes.draw do
      get "/anything" => "any#show"
    end
  end

  after do
    Rails.application.reload_routes!
  end

  describe "#return_the" do
    it "should return 404 for nil thing" do
      get "/anything"
      expect(response).to be_not_found
    end
  end
end
