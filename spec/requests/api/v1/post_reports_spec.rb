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

  describe "#index" do
    before(:all) do
      @index_admin = create(:person, product: create(:product), role: :admin)
      @index_people = [create(:person, product: @index_admin.product), create(:person, product: @index_admin.product), create(:person, product: @index_admin.product)]
      @reporting_people = [create(:person, product: @index_admin.product), create(:person, product: @index_admin.product), create(:person, product: @index_admin.product)]
      @index_posts = []
      6.times do
        @index_posts << create(:post, person: @index_people.sample)
      end
      @index_reports = []
      5.times do
        @index_reports << create(:post_report, post: @index_posts.sample, person: @reporting_people.sample, status: PostReport.statuses.keys.sample)
      end
    end
    it "should get all reports but only for correct product" do
      ActsAsTenant.with_tenant(create(:product)) do
        create(:post_report)
      end
      login_as(@index_admin)
      get "/post_reports"
      expect(response).to be_success
      expect(json["post_reports"].count).to eq(@index_reports.count)
    end
    it "should get all reports with pending status" do
      login_as(@index_admin)
      get "/post_reports", params: { status_filter: "pending" }
      expect(response).to be_success
      pending = PostReport.for_product(@index_admin.product).where(status: :pending)
      reports_json = json["post_reports"]
      expect(reports_json.count).to eq(pending.count)
      expect(reports_json.map { |rj| rj["id"] }.sort).to eq(pending.map { |pr| pr.id.to_s }.sort)
    end
    it "should return unauthorized if not logged in" do
      get "/post_reports"
      expect(response).to be_unauthorized
    end
    it "should return unauthorized if logged in as normal" do
      login_as(create(:person, product: @index_admin.product, role: :normal))
      get "/post_reports"
      expect(response).to be_unauthorized
    end
    it "should return no reports if logged in as admin from another product" do
      ActsAsTenant.with_tenant(create(:product)) do
        other = create(:person, role: :admin)
        login_as(other)
        get "/post_reports"
        expect(response).to be_success
        expect(json["post_reports"]).to be_empty
      end
    end
  end
end
