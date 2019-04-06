require 'rails_helper'

RSpec.describe Api::V1::NotificationDeviceIdsController, type: :controller do

  describe "#create" do
    it "should insert a new device id"
    it "should not insert a device id if missing identifier"
    it "should not insert a new device id if not logged in"
    it "should not insert a duplicate device id"
  end

  describe "#destroy" do
    it "should destroy a device id"
    it "should 404 if not owner"
    it "should 404 if not an id we have"
    it "should not delete if not logged in"
    it "should just return unauthorized even if bad id"
  end
end
