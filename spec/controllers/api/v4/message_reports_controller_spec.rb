# frozen_string_literal: true

require "spec_helper"

RSpec.describe Api::V4::MessageReportsController, type: :controller do
  describe "#create" do
    let(:reason) { "I don't like you" }

    it "creates a new report in a public room" do
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


    it "hides a the message if status is changed to message_hidden" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        message = create(:message, room: create(:public_active_room))
        report = create(:message_report, message: message, status: :pending)
        login_as(person)
        patch :update, params: { id: report.id, message_report: { status: "message_hidden" } }

        expect(response.body).to eq("")
        expect(response).to be_successful
        expect(report.reload.status).to eq("message_hidden")
        expect(message.reload.hidden).to eq(true)
      end
    end
  end
end
