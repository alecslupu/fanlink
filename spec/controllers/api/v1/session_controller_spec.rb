require 'rails_helper'

RSpec.describe Api::V1::SessionController, type: :controller do

  describe "#index" do
    it "should check a valid session"
    it "should 404 with no session"
  end

  describe "#create" do
    it "should log in a person with email from a regular account"
    it "should log in a person with username from a regular account"
    it "should not log in a person with wrong username from a regular account"
    it "should not log in a person with wrong email from a regular account"
    it "should log in a person via FB auth token"
    it "should not log in a person without a product"
    it "should not log in a person with a bad product"
    it "should not log in a person via bad FB auth token"
  end

  describe "#destroy" do
    it "should log you out"
  end
end
