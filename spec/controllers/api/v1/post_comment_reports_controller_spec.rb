require 'rails_helper'

RSpec.describe Api::V1::PostCommentReportsController, type: :controller do
  describe "#create" do
    let(:reason) {"I don't like you"}
    it "should create a new post comment report" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post_comment = create(:post_comment, post: create(:post))
        post :create, params: { post_id: post_comment.post_id, post_comment_report: { post_comment_id: post_comment.id, reason: reason } }
        expect(response).to be_success

        report = PostCommentReport.last
        expect(report.post_comment).to eq(post_comment)
        expect(report.person).to eq(person)
        expect(report.reason).to eq(reason)
      end
    end

    it "should not create a report if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post_comment = create(:post_comment, post: create(:post))
        post :create, params: { post_id: post_comment.post_id, post_comment_report: { post_comment_id: post_comment.id, reason: reason } }
        expect(response).to be_unauthorized
      end
    end

    it "should not create a report for a post comment from a different product"
    # do
    #   flink_post =  create(:post, person: create(:person))
    #   post_comment = create(:post_comment, post: flink_post)
    #   person = create(:person, product: create(:product))
    #   ActsAsTenant.with_tenant(person.product) do
    #     login_as(person)
    #     post :create, params: { post_id: post_comment.post_id, post_comment_report: { post_comment_id: post_comment.id, reason: reason } }
    #     expect(response).to be_not_found
    #   end
    # end
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
