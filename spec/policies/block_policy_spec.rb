# frozen_string_literal: true

require "rails_helper"

RSpec.describe BlockPolicy, type: :policy do
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
  }

  describe "defined policies" do
    subject { described_class.new(Person.new, Block.new) }

    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end

  context "logged out user" do
    subject { described_class.new(nil, Block.new) }

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
        expect(subject.send(:super_admin?)).to be_nil
      end
      it do
        expect(subject.send(:has_permission?, "bogous")).to eq(false)
      end
    end
  end

  context "user with super admin role and with admin product" do
    let(:product) { create(:product, internal_name: "admin") }

    subject { described_class.new(Person.new(role: :super_admin, product: product), Block.new) }

    describe "permissions" do
      permission_list.each do |policy, _|
        it { is_expected.to permit_action(policy) } unless policy == :show_in_app
      end

      it { is_expected.to forbid_action(:show_in_app) }
    end

    describe "protected methods" do
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
    it "should return all the records" do
      person = create(:person)

      ActsAsTenant.with_tenant(person.product) do

        block = create(:block)
        block = create(:block)

        expect(Block.count).to eq(2)

        scope = Pundit.policy_scope!(person, Block.all)
        expect(scope.count).to eq(2)
        expect(scope).to include(block)
        expect(scope).to include(block)
      end
    end
  end
end
