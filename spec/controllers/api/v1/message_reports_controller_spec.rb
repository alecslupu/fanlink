require "spec_helper"

RSpec.describe Api::V1::MessageReportsController, type: :controller do
  describe "#create" do
    let(:reason) { "I don't like you" }

    it "should create a new report in a public room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        message = create(:message, room: create(:public_active_room))
        post :create, params: { room_id: message.room_id, message_report: { message_id: message.id, reason: reason } }
        expect(response).to be_successful
        report = MessageReport.last
        expect(report.message).to eq(message)
        expect(report.person).to eq(person)
        expect(report.reason).to eq(reason)
      end
    end
    it "should not create a report of a private message" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        message = create(:message, room: create(:private_active_room))
        post :create, params: { room_id: message.room_id, message_report: { message_id: message.id, reason: reason } }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("You cannot report a private message.")
      end
    end
    it "should not create a report if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        message = create(:message, room: create(:private_active_room))
        post :create, params: { room_id: message.room_id, message_report: { message_id: message.id, reason: reason } }
        expect(response).to be_unauthorized
      end
    end
    it "should not create a report for a message from a different product" do
      person = create(:person)
      room = create(:public_active_room, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        message = create(:message, room: room)
        post :create, params: { room_id: message.room_id, message_report: { message_id: message.id, reason: reason } }
        expect(response).to be_not_found
      end
    end
  end

  describe "#index" do
    it "should get all reports but only for correct product" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        message = create(:message, room: create(:public_active_room))
        reports_pending = create_list(:message_report, 5, message: message)
        reports_solved = create(:message_report, message: message, status: :no_action_needed)
        reports = reports_pending + [reports_solved]
        login_as(person)
        get :index, params: { room_id: message.room_id }
        expect(response).to have_http_status(200)
        expect(json["message_reports"].size).to eq(reports.size)
      end
    end
    it "should get all reports with pending status" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        message = create(:message, room: create(:public_active_room))
        reports = create_list(:message_report, 5, message: message)

        get :index, params: { room_id: message.room_id, status_filter: "pending" }
        expect(response).to be_successful
        expect(json["message_reports"].count).to eq(reports.size)
        expect(message_reports_json(json["message_reports"].first)).to be true
      end
    end
    it "should page 1 of all reports with pending status" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        message = create(:message, room: create(:public_active_room))
        reports = create_list(:message_report, 5, message: message).reverse

        get :index, params: { room_id: message.room_id, status_filter: "pending", page: 1, per_page: 2 }
        expect(response).to be_successful
        expect(json["message_reports"].count).to eq(2)
        expect(message_reports_json(json["message_reports"].first)).to be true
        expect(message_reports_json(json["message_reports"].last)).to be true
        expect(json["message_reports"].first["id"].to_i).to eq(reports[0].id)
        expect(json["message_reports"].last["id"].to_i).to eq(reports[1].id)
      end
    end
    it "should return unauthorized if not logged in" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        message = create(:message, room: create(:public_active_room))
        create(:message_report, message: message)
        get :index, params: { room_id: message.room_id, status_filter: "pending" }
        expect(response).to be_unauthorized
      end
    end
    it "should return unauthorized not logged in as normal" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        message = create(:message, room: create(:public_active_room))
        create(:message_report, message: message)
        get :index, params: { room_id: message.room_id, status_filter: "pending" }
        expect(response).to be_unauthorized
      end
    end
    it "should return not get message reports if logged in as admin from another product" do
      person = create(:admin_user)
      message = create(:message, room: create(:public_active_room, product: create(:product)))
      create_list(:message_report, 5, message: message)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: { status_filter: "pending" }
        expect(response).to be_successful
        expect(json["message_reports"]).to be_empty
      end
    end
  end

  describe "#update" do
    it "should update a message report" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        message = create(:message, room: create(:public_active_room))
        report = create(:message_report, message: message)
        login_as(person)
        patch :update, params: { id: report.id, message_report: { status: "no_action_needed" } }

        expect(response).to be_successful
        expect(report.reload.status).to eq("no_action_needed")
      end
    end
    it "should not update a message report to an invalid status" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        message = create(:message, room: create(:public_active_room))
        report = create(:message_report, message: message)
        login_as(person)
        patch :update, params: { id: report.id, message_report: { status: "invalid_status_from_spec" } }

        expect(response).to be_unprocessable
      end
    end
    it "should not update a message report if not logged in" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        message = create(:message, room: create(:public_active_room))
        report = create(:message_report, message: message)
        patch :update, params: { id: report.id, message_report: { status: "no_action_needed" } }

        expect(response).to be_unauthorized
      end
    end
    it "should not update a message report if not admin" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        message = create(:message, room: create(:public_active_room))
        report = create(:message_report, message: message)
        patch :update, params: { id: report.id, message_report: { status: "no_action_needed" } }

        expect(response).to be_unauthorized
      end
    end
  end
end
