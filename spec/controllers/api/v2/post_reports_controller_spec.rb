require "spec_helper"

RSpec.describe Api::V2::PostReportsController, type: :controller do
  describe "#create" do
    it "should create a new report" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        p = create(:post, person: create(:person))
        reason = "I don't like you"
        post :create, params: { post_report: { post_id: p.id, reason: reason } }
        expect(response).to be_successful
        report = PostReport.last
        expect(report.post).to eq(p)
        expect(report.person).to eq(person)
        expect(report.reason).to eq(reason)
      end
    end
    it "should not create a report if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        p = create(:post, person: person)
        expect {
          post :create, params: { post_report: { post_id: p.id } }
        }.to change { PostReport.count }.by(0)
        expect(response).to be_unauthorized
      end
    end
    it "should not create a report for a post from a different product" do
      person = create(:person)
      user = create(:person, product: create(:product))
      p = create(:post, person: user)

      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expect {
          post :create, params: { post_report: { post_id: p.id } }
        }.to change { PostReport.count }.by(0)
        expect(response).to be_not_found
      end
    end
  end

  describe "#index" do
    it "should get all reports but only for correct product" do
      admin = create(:admin_user)
      create_list(:post_report, 3, post: create(:post, person: admin))
      user = create(:person, product: create(:product))
      create_list(:post_report, 3, post: create(:post, person: user))

      ActsAsTenant.with_tenant(admin.product) do
        login_as(admin)
        get :index
        expect(response).to be_successful
        expect(json["post_reports"].count).to eq(3)
      end
    end
    it "should get all reports paginated to page 1" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        create_list(:post_report, 10)
        login_as(admin)
        get :index, params: { page: 1, per_page: 2 }
        expect(response).to be_successful
        expect(json["post_reports"].count).to eq(2)
        expect(post_report_json(json["post_reports"].first)).to be true
        expect(post_report_json(json["post_reports"].last)).to be true
      end
    end
    it "should get all reports paginated to page 2" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        create_list(:post_report, 10)
        login_as(admin)
        get :index, params: { page: 2, per_page: 2 }
        expect(response).to be_successful
        expect(json["post_reports"].count).to eq(2)
        expect(post_report_json(json["post_reports"].first)).to be true
        expect(post_report_json(json["post_reports"].last)).to be true
      end
    end
    it "should get all reports with pending status" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        5.times do
          create(:post_report, status: PostReport.statuses.keys.sample)
        end

        login_as(admin)
        get :index, params: { status_filter: "pending" }
        expect(response).to be_successful
        pending = PostReport.for_product(admin.product).where(status: :pending)
        reports_json = json["post_reports"]
        expect(reports_json.count).to eq(pending.count)
        expect(reports_json.map { |rj| rj["id"] }.sort).to eq(pending.map { |pr| pr.id.to_s }.sort)
      end
    end
    it "should return unauthorized if not logged in" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        get :index
        expect(response).to be_unauthorized
      end
    end
    it "should return unauthorized if logged in as normal" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        person = create(:person)
        login_as(person)
        get :index
        expect(response).to be_unauthorized
      end
    end
    it "should return no reports if logged in as admin from another product" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        other = create(:admin_user)
        login_as(other)
        get :index
        expect(response).to be_successful
        expect(json["post_reports"]).to be_empty
      end
    end
  end

  describe "#update" do
    it "should update a post report" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        report = create(:post_report)
        login_as(admin)
        patch :update, params: { id: report.id, post_report: { status: "no_action_needed" } }
        expect(response).to be_successful
        expect(report.reload.status).to eq("no_action_needed")
      end
    end
    it "should not update a post report to an invalid status" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        report = create(:post_report)
        login_as(admin)
        patch :update, params: { id: report.id, post_report: { status: "punting" } }
        expect(response).to be_unprocessable
      end
    end
    it "should not update a post report if not logged in" do
      normal = create(:person)
      ActsAsTenant.with_tenant(normal.product) do
        report = create(:post_report)
        patch :update, params: { id: report.id, post_report: { status: "pending" } }
        expect(response).to be_unauthorized
      end
    end
    it "should not update a post report if not admin" do
      normal = create(:person)
      ActsAsTenant.with_tenant(normal.product) do
        report = create(:post_report)
        login_as(normal)
        patch :update, params: { id: report.id, post_report: { status: "pending" } }
        expect(response).to be_unauthorized
      end
    end
  end
end
