require 'rails_helper'

RSpec.describe Api::V1::BadgesController, type: :controller do

  describe "#index" do
    it "should return all badges for a passed in person"
    it "should return 404 for non-existent passed in person"
    it "should return 404 for passed in person from another product"
  end
end
