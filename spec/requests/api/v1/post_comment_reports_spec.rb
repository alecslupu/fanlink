describe "PostCommentReports (v1)" do

  before(:all) do
    @post_comment = create(:post_comment)
    @person = create(:person, product: @post_comment.product)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new post comment report" do
      login_as(@person)
      reason = "I don't like you"
      post "/post_comment_reports", params: { post_comment_report: { post_comment_id: @post_comment.id, reason: reason } }
      expect(response).to be_success
      report = PostCommentReport.last
      expect(report.post_comment).to eq(@post_comment)
      expect(report.person).to eq(@person)
      expect(report.reason).to eq(reason)
    end
    it "should not create a report if not logged in" do
      expect {
        post "/post_comment_reports", params: { post_comment_report: { post_comment_id: @post_comment.id, reason: "abc" } }
      }.to change { PostCommentReport.count }.by(0)
      expect(response).to be_unauthorized
    end
    it "should not create a report for a post comment from a different product" do
      login_as(@person)
      person = create(:person, product: create(:product))
      p = create(:post, person: person)
      expect {
        post "/post_comment_reports", params: { post_comment_report: { post_comment_id: p.id } }
      }.to change { PostCommentReport.count }.by(0)
      expect(response).to be_not_found
    end
  end
end
