require 'rails_helper'

RSpec.describe Api::V1::MerchandiseController, type: :controller do

  describe "#index" do
    it "should get the available merchandise in priority order"
    it "should not get the available merchandise if not logged in"
  end

  describe "#show" do
    it "should get a single piece of available merchandise"
    it "should not get the available merchandise if not logged in"
    it "should not get merchandise from a different product"
  end
end
