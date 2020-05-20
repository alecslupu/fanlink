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

  describe "#index" do
    before(:all) do
      @index_admin = create(:person, product: create(:product), role: :admin)
      @index_people = [create(:person, product: @index_admin.product), create(:person, product: @index_admin.product), create(:person, product: @index_admin.product)]
      @reporting_people = [create(:person, product: @index_admin.product), create(:person, product: @index_admin.product), create(:person, product: @index_admin.product)]
      @index_post_comments = []
      6.times do
        @index_post_comments << create(:post_comment, person: @index_people.sample)
      end
      @index_reports = []
      base_time = Time.zone.now - 4.days
      5.times do |n|
        @index_reports << create(:post_comment_report, post_comment: @index_post_comments.sample,
                                 person: @reporting_people.sample, status: PostCommentReport.statuses.keys.sample,
                                 created_at: base_time + n.hours)
      end
    end
    it "should get all reports but only for correct product" do
      ActsAsTenant.with_tenant(create(:product)) do
        create(:post_comment_report)
      end
      login_as(@index_admin)
      get "/post_comment_reports", params: { page: 1, per_page: 100 }
      expect(response).to be_success
      expect(json["post_comment_reports"].count).to eq(@index_reports.count)
    end
    it "should get all reports paginated to page 1" do
      login_as(@index_admin)
      get "/post_comment_reports", params: { page: 1, per_page: 2 }
      expect(response).to be_success
      expect(json["post_comment_reports"].count).to eq(2)
      # expect(json["post_comment_reports"].first).to eq(post_comment_report_json(@index_reports.last))
      # expect(json["post_comment_reports"].last).to eq(post_comment_report_json(@index_reports[-2]))
      expect(post_comment_report_json(json["post_comment_reports"].first)).to be true
      expect(post_comment_report_json(json["post_comment_reports"].last)).to be true
    end
    it "should get all reports paginated to page 2" do
      login_as(@index_admin)
      get "/post_comment_reports", params: { page: 2, per_page: 2 }
      expect(response).to be_success
      expect(json["post_comment_reports"].count).to eq(2)
      # expect(json["post_comment_reports"].first).to eq(post_comment_report_json(@index_reports[-3]))
      # expect(json["post_comment_reports"].last).to eq(post_comment_report_json(@index_reports[-4]))
      expect(post_comment_report_json(json["post_comment_reports"].first)).to be true
      expect(post_comment_report_json(json["post_comment_reports"].last)).to be true
    end
    it "should get all reports with pending status" do
      login_as(@index_admin)
      get "/post_comment_reports", params: { status_filter: "pending" }
      expect(response).to be_success
      pending = PostCommentReport.for_product(@index_admin.product).where(status: :pending)
      expect(json["post_comment_reports"].count).to eq(pending.count)
      expect(json["post_comment_reports"].map { |rj| rj["id"] }.sort).to eq(pending.map { |pr| pr.id.to_s }.sort)
    end
    it "should return unauthorized if not logged in" do
      get "/post_comment_reports"
      expect(response).to be_unauthorized
    end
    it "should return unauthorized if logged in as normal" do
      login_as(create(:person, product: @index_admin.product, role: :normal))
      get "/post_comment_reports"
      expect(response).to be_unauthorized
    end
    it "should return no reports if logged in as admin from another product" do
      ActsAsTenant.with_tenant(create(:product)) do
        other = create(:person, role: :admin)
        login_as(other)
        get "/post_comment_reports"
        expect(response).to be_success
        expect(json["post_comment_reports"]).to be_empty
      end
    end
  end

  describe "#update" do
    let(:post_comment) { create(:post_comment) }
    let(:report) { create(:post_comment_report, post_comment: post_comment) }
    let(:admin) { create(:person, product: report.person.product, role: :admin) }
    it "should update a post comment report" do
      login_as(admin)
      patch "/post_comment_reports/#{report.id}", params: { post_comment_report: { status: "no_action_needed" } }
      expect(response).to be_success
      expect(report.reload.status).to eq("no_action_needed")
    end
    it "should not update a post comment report to an invalid status" do
      login_as(admin)
      patch "/post_comment_reports/#{report.id}", params: { post_comment_report: { status: "punting" } }
      expect(response).to be_unprocessable
    end
    it "should not update a post comment report if not logged in" do
      patch "/post_comment_reports/#{report.id}", params: { post_comment_report: { status: "pending" } }
      expect(response).to be_unauthorized
    end
    it "should not update a post comment report if not admin" do
      login_as(create(:person, product: post_comment.product, role: :normal))
      patch "/post_comment_reports/#{report.id}", params: { post_comment_report: { status: "pending" } }
      expect(response).to be_unauthorized
    end
  end

end
