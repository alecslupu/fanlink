# frozen_string_literal: true

require "spec_helper"

RSpec.describe MessageReportPolicy, type: :policy do
  let(:master_class) { MessageReport.new }
  subject { described_class.new(build(:person), master_class) }

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
    select_product: false
  }

  describe "defined policies" do
    subject { described_class.new(build(:person), master_class) }
    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end
  context "logged in user with no permission" do
    subject { described_class.new(build(:person), master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:module_name)).to eq("chat") }
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, "bogous")).to eq(false) }
      it { expect(subject.send(:has_permission?, "index")).to eq(false) }
    end
  end
  context "logged in admin with no permission" do
    subject { described_class.new(build(:admin_user), master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, "bogous")).to eq(false) }
      it { expect(subject.send(:has_permission?, "index")).to eq(false) }
    end
  end
  context "logged in admin with read permission" do
    permission_list = {
      index: true,
      show: true,
      create: false,
      new: false,
      update: false,
      edit: false,
      destroy: false,
      export: false,
      history: false,
      show_in_app: false,
      select_product: false
    }
    subject { described_class.new(create(:portal_access, chat_read: true).person, master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, "bogous")).to eq(false) }
      it { expect(subject.send(:has_permission?, "index")).to eq(false) }
    end
  end
  context "logged in admin with update permission" do
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
      select_product: false
    }
    subject { described_class.new(create(:portal_access, chat_update: true).person, master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, "bogous")).to eq(false) }
      it { expect(subject.send(:has_permission?, "index")).to eq(false) }
    end
  end
  context "logged in admin with delete permission" do
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
      select_product: false
    }
    subject { described_class.new(create(:portal_access, chat_delete: true).person, master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, "bogous")).to eq(false) }
      it { expect(subject.send(:has_permission?, "index")).to eq(false) }
    end
  end
  context "logged in admin with export permission" do
    permission_list = {
      index: false,
      show: false,
      create: false,
      new: false,
      update: false,
      edit: false,
      destroy: false,
      export: true,
      history: false,
      show_in_app: false,
      select_product: false
    }
    subject { described_class.new(create(:portal_access, chat_export: true).person, master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, "bogous")).to eq(false) }
      it { expect(subject.send(:has_permission?, "index")).to eq(false) }
    end
  end
  context "logged in admin with history permission" do
    permission_list = {
      index: false,
      show: false,
      create: false,
      new: false,
      update: false,
      edit: false,
      destroy: false,
      export: false,
      history: true,
      show_in_app: false,
      select_product: false
    }
    subject { described_class.new(create(:portal_access, chat_history: true).person, master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, "bogous")).to eq(false) }
      it { expect(subject.send(:has_permission?, "index")).to eq(false) }
    end
  end

  context "Logged in admin with chat_hide permission" do
    describe "message report with no action needed status" do
      let(:portal_access) { create(:portal_access, chat_hide: true) }
      subject { described_class.new(Person.find(portal_access.person_id), MessageReport.new(status: :no_action_needed)) }

      it { is_expected.to permit_action(:hide_message_action) }
      it { is_expected.to permit_action(:reanalyze_message_action) }
      it { is_expected.to forbid_action(:ignore_message_action) }
    end
  end

  context "Logged in admin with chat ignore permission" do
    describe "message report with pending status" do
      let(:portal_access) { create(:portal_access, chat_ignore: true) }
      subject { described_class.new(Person.find(portal_access.person_id), MessageReport.new(status: :pending)) }

      it { is_expected.to permit_action(:ignore_message_action) }
      it { is_expected.to forbid_action(:hide_message_action) }
      it { is_expected.to forbid_action(:reanalyze_message_action) }
    end
  end

  context "Scope" do
    it "should only return the messages from public rooms" do
      person = build(:person)
      current_product = person.product
      another_product = create(:product)
      message_report2 = ActsAsTenant.with_tenant(another_product) { create(:message_report, person: build(:person)) }

      ActsAsTenant.with_tenant(current_product) do
        message_report = create(:message_report, person: person)
        scope = Pundit.policy_scope!(person, MessageReport)
        expect(scope.count).to eq(1)
        expect(scope).to include(message_report)
        expect(scope).not_to include(message_report2)
      end
    end
  end
end


