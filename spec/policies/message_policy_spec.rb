require "rails_helper"

RSpec.describe MessagePolicy, type: :policy do
  subject { described_class.new(person, message) }

  let(:person) { nil }


  context "CRUD actions" do
    let(:message) { Message.new }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_actions(%i[index show]) }
  end

  describe "#hide_action" do
    context "an unhidden message" do
      let(:message) { Message.new(hidden: false) }
      it { is_expected.to permit_action(:hide_action) }
    end

    context "a hidden message" do
      let(:message) { Message.new(hidden: true) }
      it { is_expected.to forbid_action(:hide_action) }
    end
  end

  describe "#unhide_action" do
    context "a hidden message" do
      let(:message) { Message.new(hidden: true) }
      it { is_expected.to permit_action(:unhide_action) }
    end

    context "an unhidden message" do
      let(:message) { Message.new(hidden: false) }
      it { is_expected.to forbid_action(:unhide_action) }
    end
  end

  context "Scope" do
    it "should only return messages from current product's public rooms" do
      ActsAsTenant.without_tenant do
        current_product = create(:product)
        another_product = create(:product)

        public_room = create(:room, public: true)
        private_room = create(:room)
        public_room_from_another_product = create(:room, public: true, product_id: another_product.id)

        create(:message, room_id: private_room.id)
        create(:message, room_id: public_room_from_another_product.id)
        message = create(:message, room_id: public_room.id)
        message2 = create(:message, room_id: public_room.id)
        expect(Message.count).to eq(4) # to test if all the messages are created

        ActsAsTenant.current_tenant = current_product
        scope = Pundit.policy_scope!(person, Message.all)
        expect(scope.count).to eq(2)
        expect(scope).to include(message)
        expect(scope).to include(message2)
      end
    end
  end
end
