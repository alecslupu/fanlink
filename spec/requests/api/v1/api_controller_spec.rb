class AnyController < ApiController
  skip_before_action :require_login, :set_product
  def show
    return_the nil
  end

  def show_erred
    person = FactoryBot.create(:person)
    person.username = "a"
    return_the person
  end
end


describe "Api (v1)" do

  before(:all) do
    Rails.application.routes.draw do
      get "/anything" => "any#show"
      get "/anything_erred" => "any#show_erred"
    end
  end

  after(:all) do
    Rails.application.reload_routes!
  end

  describe "#return_the" do
    it "should return 404 for nil thing" do
      get "/anything"
      expect(response).to be_not_found
    end
    it "should return 422 for erred thing" do
      get "/anything_erred"
      expect(response).to be_unprocessable
    end
  end
end
