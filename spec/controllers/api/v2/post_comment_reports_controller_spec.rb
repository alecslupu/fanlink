require "spec_helper"

RSpec.describe Api::V2::PostCommentReportsController, type: :controller do
  describe "#create" do
    let(:reason) { "I don't like you" }
    it "should create a new post comment report" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post_comment = create(:post_comment, post: create(:post))
        post :create, params: { post_id: post_comment.post_id, post_comment_report: { post_comment_id: post_comment.id, reason: reason } }
        expect(response).to be_successful

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

    it "should not create a report for a post comment from a different product" do
      post_comment = create(:post_comment)
      person = create(:person, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post :create, params: { post_id: post_comment.post_id, post_comment_report: { post_comment_id: post_comment.id, reason: reason } }
        expect(response).to be_not_found
      end
    end
  end

  describe "#index" do
    it "should get all reports but only for correct product" do
      7.times do
        ActsAsTenant.with_tenant(create(:product)) { create(:post_comment_report) }
      end

      admin = create(:admin_user, product: create(:product))
      ActsAsTenant.with_tenant(admin.product) do
        login_as(admin)
        5.times { create(:post_comment_report) }
        get :index, params: { page: 1, per_page: 100 }
        expect(response).to be_successful
        expect(json["post_comment_reports"].count).to eq(5)
      end
    end
    it "should get all reports paginated to page 1" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        login_as(admin)
        5.times do |n|
          create(:post_comment_report, status: PostCommentReport.statuses.keys.sample)
        end
        get :index, params: { page: 1, per_page: 2 }
        expect(response).to be_successful
        expect(json["post_comment_reports"].count).to eq(2)
        # expect(json["post_comment_reports"].first).to eq(post_comment_report_json(@index_reports.last))
        # expect(json["post_comment_reports"].last).to eq(post_comment_report_json(@index_reports[-2]))
        expect(post_comment_report_json(json["post_comment_reports"].first)).to be true
        expect(post_comment_report_json(json["post_comment_reports"].last)).to be true
      end
    end
    it "should get all reports paginated to page 2" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        login_as(admin)
        5.times do |n|
          create(:post_comment_report, status: PostCommentReport.statuses.keys.sample)
        end
        get :index, params: { page: 2, per_page: 2 }
        expect(response).to be_successful
        expect(json["post_comment_reports"].count).to eq(2)
        # expect(json["post_comment_reports"].first).to eq(post_comment_report_json(@index_reports[-3]))
        # expect(json["post_comment_reports"].last).to eq(post_comment_report_json(@index_reports[-4]))
        expect(post_comment_report_json(json["post_comment_reports"].first)).to be true
        expect(post_comment_report_json(json["post_comment_reports"].last)).to be true
      end
    end
    it "should get all reports with pending status" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        login_as(admin)
        5.times do |n|
          create(:post_comment_report, status: PostCommentReport.statuses.keys.sample)
        end

        get :index, params: { status_filter: "pending" }
        expect(response).to be_successful
        pending = PostCommentReport.for_product(admin.product).where(status: :pending)
        expect(json["post_comment_reports"].count).to eq(pending.count)
        expect(json["post_comment_reports"].map { |rj| rj["id"] }.sort).to eq(pending.map { |pr| pr.id.to_s }.sort)
      end
    end
    it "should return unauthorized if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        get :index
        expect(response).to be_unauthorized
      end
    end
    it "should return unauthorized if logged in as normal" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index
        expect(response).to be_unauthorized
      end
    end
    it "should return no reports if logged in as admin from another product" do
      ActsAsTenant.with_tenant(create(:product)) do
        other = create(:admin_user, product: create(:product))
        login_as(other)
        get :index
        expect(response).to be_successful
        expect(json["post_comment_reports"]).to be_empty
      end
    end
  end

  describe "#update" do
    it "should update a post comment report" do
      report = create(:post_comment_report)

      ActsAsTenant.with_tenant(report.post_comment.product) do
        admin = create(:admin_user)
        login_as(admin)
        patch :update, params: { id: report.id, post_comment_report: { status: "no_action_needed" } }
        expect(response).to be_successful
        expect(report.reload.status).to eq("no_action_needed")
      end
    end
    it "should not update a post comment report to an invalid status" do
      report = create(:post_comment_report)

      ActsAsTenant.with_tenant(report.post_comment.product) do
        admin = create(:admin_user)
        login_as(admin)
        patch :update, params: { id: report.id, post_comment_report: { status: "punting" } }
        expect(response).to be_unprocessable
      end
    end
    it "should not update a post comment report if not logged in" do
      report = create(:post_comment_report)

      ActsAsTenant.with_tenant(report.post_comment.product) do
        patch :update, params: { id: report.id, post_comment_report: { status: "pending" } }
        expect(response).to be_unauthorized
      end
    end
    it "should not update a post comment report if not admin" do
      report = create(:post_comment_report)

      ActsAsTenant.with_tenant(report.post_comment.product) do
        login_as(create(:person))
        patch :update, params: { id: report.id, post_comment_report: { status: "pending" } }
        expect(response).to be_unauthorized
      end
    end
  end
end
