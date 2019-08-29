require "rails_helper"

RSpec.describe MessagePolicy, type: :policy do
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
    unhide_action: false,
    hide_action: false
  }

  describe "defined policies" do
    subject { described_class.new(Person.new, Message.new) }

    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end

  context "logged out user" do
    subject { described_class.new(Person.new, Message.new) }

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
      subject { described_class.new(Person.new(role: :super_admin, product: product), Message.new) }

      [:index, :show, :destroy, :export, :history, :dashboard, :select_product].each do |policy|
        it { is_expected.to permit_action(policy) }
      end

      [:create, :new, :update, :edit, :show_in_app].each do |policy|
        it { is_expected.to forbid_action(policy) }
      end
    end

    describe "hide and unhide actions for a unhidden message" do
      subject { described_class.new(Person.new(role: :super_admin, product: product), Message.new(hidden: false)) }

      it { is_expected.to permit_action(:hide_action) }
      it { is_expected.to forbid_action(:unhide_action) }
    end

    describe "hide and unhide actions for a hidden message" do
      subject { described_class.new(Person.new(role: :super_admin, product: product), Message.new(hidden: true)) }

      it { is_expected.to forbid_action(:hide_action) }
      it { is_expected.to permit_action(:unhide_action) }
    end

    describe "protected methods" do
      subject { described_class.new(Person.new(role: :super_admin, product: product), Message.new) }

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

  context "Scope" do
    it "should only return the messages from public rooms" do
      person = create(:person)

      ActsAsTenant.with_tenant(person.product) do
        current_product = create(:product)
        another_product = create(:product)

        public_room = create(:room, public: true)
        private_room = create(:room)

        message = create(:message, room: public_room)
        message2 = create(:message, room: public_room)
        create(:message, room: private_room)

        expect(Message.count).to eq(3)

        scope = Pundit.policy_scope!(person, Message.all)
        expect(scope.count).to eq(2)
        expect(scope).to include(message)
        expect(scope).to include(message2)
      end
    end
  end
end
