# frozen_string_literal: true

require "spec_helper"

RSpec.describe ApplicationPolicy, type: :policy do
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
    subject { described_class.new(nil, nil) }

    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end
  context "logged out user" do
    subject { described_class.new(nil, Person) }

    describe "permissions" do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe "protected methods" do
      it do
        expect(subject.send(:module_name)).to eq("admin")
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

    subject { described_class.new(Person.new(role: :super_admin, product: product), nil) }

    describe "permissions" do
      permission_list.each do |policy, _|
        it { is_expected.to permit_action(policy) } unless policy == :show_in_app
      end

      it { is_expected.to forbid_action(:show_in_app) }
    end

    describe "protected methods" do
      it do
        expect(subject.send(:module_name)).to eq("admin")
      end
      it do
        expect(subject.send(:super_admin?)).to eq(true)
      end
      it do
        expect(subject.send(:has_permission?, "bogous")).to eq(true)
      end
    end
  end

  # subject { described_class.new(person, message) }
  #
  # let(:person) { nil }
  #
  # context "CRUD actions" do
  #   let(:message) { Message.new }
  #
  #   it { is_expected.to permit_new_and_create_actions }
  #   it { is_expected.to permit_edit_and_update_actions }
  #   it { is_expected.to forbid_action(:destroy) }
  #   it { is_expected.to permit_action(:index) }
  #   it { is_expected.to permit_action(:show) }
  # end
  #
  # context "Rails admin actions" do
  #   let(:message) { Message.new }
  #
  #   it { is_expected.to permit_actions(%i[export history dashboard select_product_dashboard]) }
  #   it { is_expected.to forbid_actions(%i[show_in_app generate_game_action]) }
  # end
  #
  # describe "#select_product" do
  #   let(:message) { Message.new }
  #
  #   context "superadmin who has the admin product assigned" do
  #     let(:product) { create(:product, internal_name: "admin") }
  #     let(:person) { Person.new(product: product, role: :super_admin) }
  #
  #     it { is_expected.to permit_action(:select_product) }
  #   end
  #
  #   context "admin who has the admin product assigned" do
  #     let(:product) { create(:product, internal_name: "admin") }
  #     let(:person) { Person.new(product: product, role: :admin) }
  #
  #     it { is_expected.to forbid_action(:select_product) }
  #   end
  #
  #   context "superadmin who doesn't have admin product assigned" do
  #     let(:product) { create(:product, internal_name: "not_admin") }
  #     let(:person) { Person.new(product: product, role: :super_admin) }
  #
  #     it { is_expected.to forbid_action(:select_product) }
  #   end
  # end
end
