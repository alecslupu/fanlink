describe "PostReports (v1)" do

  before(:all) do
    @post = create(:post)
    @person = create(:person, product: @post.product)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new report" do
      login_as(@person)
      reason = "I don't like you"
      post "/post_reports", params: { post_report: { post_id: @post.id, reason: reason } }
      expect(response).to be_success
      report = PostReport.last
      expect(report.post).to eq(@post)
      expect(report.person).to eq(@person)
      expect(report.reason).to eq(reason)
    end
    it "should not create a report if not logged in" do
      expect {
        post "/post_reports", params: { post_report: { post_id: @post.id } }
      }.to change { PostReport.count }.by(0)
      expect(response).to be_unauthorized
    end
    it "should not create a report for a post from a different product" do
      login_as(@person)
      person = create(:person, product: create(:product))
      p = create(:post, person: person)
      expect {
        post "/post_reports", params: { post_report: { post_id: p.id } }
      }.to change { PostReport.count }.by(0)
      expect(response).to be_not_found
    end
  end
end