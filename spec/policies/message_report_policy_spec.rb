require "rails_helper"

RSpec.describe MessageReportPolicy, type: :policy do
  subject { described_class.new(person, message_report) }

  let(:person) { nil }


  context "CRUD actions" do
    let(:message_report) { MessageReport.new }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_actions(%i[index show]) }
  end

  describe "#hide_message_action" do
    context "a message that has message_hidden status" do
      let(:message_report) { MessageReport.new(status: :message_hidden) }
      it { is_expected.to forbid_action(:hide_message_action) }
    end

    context "a message that has no_action_needed" do
      let(:message_report) { MessageReport.new(status: :no_action_needed) }
      it { is_expected.to permit_action(:hide_message_action) }
    end
  end

  describe "#ignore_action" do
    context "a message that has no_action_needed" do
      let(:message_report) { MessageReport.new(status: :no_action_needed) }
      it { is_expected.to forbid_action(:ignore_action) }
    end

    context "a message that has message_hidden status" do
      let(:message_report) { MessageReport.new(status: :message_hidden) }
      it { is_expected.to permit_action(:ignore_action) }
    end
  end

  describe "#reanalyze_action" do
    context "a message that has message_hidden status" do
      let(:message_report) { MessageReport.new(status: :pending) }
      it { is_expected.to forbid_action(:reanalyze_action) }
    end

    context "a message that has no_action_needed" do
      let(:message_report) { MessageReport.new(status: :no_action_needed) }
      it { is_expected.to permit_action(:reanalyze_action) }
    end
  end

  context "Scope" do
    it "should only return message reports from current product" do
      ActsAsTenant.without_tenant do
        person = create(:person, role: :admin)
        current_product = create(:product)
        another_product = create(:product)
        room = create(:room, public: true, product_id: current_product.id)
        room_from_another_product = create(:room, public: true, product_id: another_product.id)

        message = create(:message, room_id: room.id)
        message2 = create(:message, room_id: room.id)
        message3 = create(:message, room_id: room_from_another_product.id)

        message_report = create(:message_report, message_id: message.id)
        message_report2 = create(:message_report, message_id: message2.id)
        create(:message_report, message_id: message3.id)

        ActsAsTenant.current_tenant = current_product
        scope = Pundit.policy_scope!(person, MessageReport.all)
        expect(MessageReport.count).to eq(3) # to test if all the messages were created
        expect(scope.count).to eq(2)
        expect(scope).to include(message_report)
        expect(scope).to include(message_report2)
      end
    end
  end
end
