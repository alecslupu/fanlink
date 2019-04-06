require 'rails_helper'

RSpec.describe Api::V1::PostCommentReportsController, type: :controller do
  describe "#create" do
    it "should create a new post comment report"
    it "should not create a report if not logged in"
    it "should not create a report for a post comment from a different product"
  end

  describe "#index" do
    it "should get all reports but only for correct product"
    it "should get all reports paginated to page 1"
    it "should get all reports paginated to page 2"
    it "should get all reports with pending status"
    it "should return unauthorized if not logged in"
    it "should return unauthorized if logged in as normal"
    it "should return no reports if logged in as admin from another product"
  end

  describe "#update" do
    it "should update a post comment report"
    it "should not update a post comment report to an invalid status"
    it "should not update a post comment report if not logged in"
    it "should not update a post comment report if not admin"
  end
end
