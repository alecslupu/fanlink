require 'rails_helper'

RSpec.describe Api::V1::MessageReportsController, type: :controller do

  describe "#create" do
    it "should create a new report in a public room"
    it "should not create a report of a private message"
    it "should not create a report if not logged in"
    it "should not create a report for a message from a different product"
  end

  describe "#index" do
    it "should get all reports but only for correct product"
    it "should get all reports with pending status"
    it "should page 1 of all reports with pending status"
    it "should return unauthorized if not logged in"
    it "should return unauthorized not logged in as normal"
    it "should return not get message reports if logged in as admin from another product"
  end

  describe "#update" do
    it "should update a message report"
    it "should not update a message report to an invalid status"
    it "should not update a message report if not logged in"
    it "should not update a message report if not admin"
  end
end
