require "rails_helper"

RSpec.describe MessageReportPolicy, type: :policy do
  permission_list = {
    index: false,
    show: false,
    create: false,
    new: false,
    update: false,
    edit: false,
    destroy: false,
    export: false,
    history: false,
    show_in_app: false,
    dashboard: false,
    # select_product_dashboard: false,
    select_product: false,
    hide_message_action: false,
    ignore_action: false,
    reanalyze_action: false
  }

  describe "defined policies" do
    subject { described_class.new(Person.new, MessageReport.new) }

    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end

  context "logged out user" do
    subject { described_class.new(Person.new, MessageReport.new) }

    describe "permissions" do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe "protected methods" do
      it do
        expect(subject.send(:module_name)).to eq("chat")
      end
      it do
        expect(subject.send(:super_admin?)).to eq(false)
      end
      it do
        expect(subject.send(:has_permission?, "bogous")).to eq(false)
      end
    end
  end

  context "user with super admin role and with admin product" do
    let(:product) { create(:product, internal_name: "admin") }

    describe "general permissions" do
      subject { described_class.new(Person.new(role: :super_admin, product: product), MessageReport.new) }

      [:index, :show, :export, :history, :dashboard, :select_product].each do |policy|
        it { is_expected.to permit_action(policy) }
      end

      [:create, :new, :update, :edit, :destroy, :show_in_app].each do |policy|
        it { is_expected.to forbid_action(policy) }
      end
    end

    describe "hide message/ignore/reanalyze actions for a hidden MessageReport" do
      subject { described_class.new(Person.new(role: :super_admin, product: product), MessageReport.new(status: :message_hidden)) }
      it { is_expected.to forbid_action(:hide_message_action) }
      it { is_expected.to permit_action(:ignore_action) }
      it { is_expected.to permit_action(:reanalyze_action) }
    end

    describe "hide message/ignore/reanalyze actions for a MessageReport with no action needed status" do
      subject { described_class.new(Person.new(role: :super_admin, product: product), MessageReport.new(status: :no_action_needed)) }

      it { is_expected.to forbid_action(:ignore_action) }
      it { is_expected.to permit_action(:hide_message_action) }
      it { is_expected.to permit_action(:reanalyze_action) }
    end

    describe "hide message/ignore/reanalyze actions for a pending MessageReport" do
      subject { described_class.new(Person.new(role: :super_admin, product: product), MessageReport.new(status: :pending)) }

      it { is_expected.to forbid_action(:reanalyze_action) }
      it { is_expected.to permit_action(:hide_message_action) }
      it { is_expected.to permit_action(:ignore_action) }
    end

    describe "protected methods" do
      subject { described_class.new(Person.new(role: :super_admin, product: product), MessageReport.new) }

      it do
        expect(subject.send(:module_name)).to eq("chat")
      end
      it do
        expect(subject.send(:super_admin?)).to eq(true)
      end
      it do
        expect(subject.send(:has_permission?, "bogous")).to eq(true)
      end
    end
  end

  context "hide message/ignore/reanalyze actions for a normal user" do
    describe "hide permission for a pending message" do
      let(:portal_access) { create(:portal_access, chat_hide: true) }
      subject { described_class.new(Person.find(portal_access.person_id), MessageReport.new(status: :pending)) }

      it { is_expected.to permit_action(:hide_message_action) }
      it { is_expected.to forbid_action(:reanalyze_action) }
      it { is_expected.to forbid_action(:ignore_action) }
    end

    describe "ignore permission for a pending message" do
      let(:portal_access) { create(:portal_access, chat_ignore: true) }
      subject { described_class.new(Person.find(portal_access.person_id), MessageReport.new(status: :pending)) }

      it { is_expected.to permit_action(:ignore_action) }
      it { is_expected.to forbid_action(:reanalyze_action) }
      it { is_expected.to forbid_action(:hide_message_action) }
    end

    describe "hide permission for a hidden message" do
      let(:portal_access) { create(:portal_access, chat_hide: true) }
      subject { described_class.new(Person.find(portal_access.person_id), MessageReport.new(status: :message_hidden)) }

      it { is_expected.to permit_action(:reanalyze_action) }
      it { is_expected.to forbid_action(:hide_message_action) }
      it { is_expected.to forbid_action(:ignore_action) }
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
