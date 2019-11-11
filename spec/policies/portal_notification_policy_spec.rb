# frozen_string_literal: true

require "spec_helper"

RSpec.describe PortalNotificationPolicy, type: :policy do
  let(:master_class) { PortalNotification.new }
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
    select_product: false,
  }

  describe "defined policies" do
    subject { described_class.new(nil, master_class) }
    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end
  context "logged out user" do
    subject { described_class.new(nil, master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:module_name)).to eq("user") }
      it { expect(subject.send(:super_admin?)).to be_nil }
      it { expect(subject.send(:has_permission?, "bogous")).to eq(false) }
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
      select_product: false,
    }
    subject { described_class.new(create(:portal_access, user_read: true).person, master_class) }

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
      create: true,
      new: true,
      update: true,
      edit: true,
      destroy: false,
      export: false,
      history: false,
      show_in_app: false,
      select_product: false,
    }
    subject { described_class.new(create(:portal_access, user_update: true).person, master_class) }

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
      destroy: true,
      export: false,
      history: false,
      show_in_app: false,
      select_product: false,
    }
    subject { described_class.new(create(:portal_access, user_delete: true).person, master_class) }

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
      select_product: false,
    }
    subject { described_class.new(create(:portal_access, user_export: true).person, master_class) }

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
      select_product: false,
    }
    subject { described_class.new(create(:portal_access, user_history: true).person, master_class) }

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

  context "object default attributes" do
    subject { described_class.new(create(:portal_access, chat_history: true).person, master_class) }

    describe ".attributes_for" do
      it { expect(subject.attributes_for(:read)).to eq({}) }
      it { expect(subject.attributes_for(:update)).to eq({trigger_admin_notification: true}) }
      it { expect(subject.attributes_for(:create)).to eq({trigger_admin_notification: true}) }
      it { expect(subject.attributes_for(:new)).to eq({send_me_at: (Time.zone.now + 1.hour).beginning_of_hour}) }
    end
  end
end
