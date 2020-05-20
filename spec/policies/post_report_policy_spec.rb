# frozen_string_literal: true

require "spec_helper"

RSpec.describe PostReportPolicy, type: :policy do
  let(:master_class) { PostReport.new }
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
      it { expect(subject.send(:module_name)).to eq("post") }
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
    subject { described_class.new(create(:portal_access, post_read: true).person, master_class) }

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
    subject { described_class.new(create(:portal_access, post_update: true).person, master_class) }

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
    subject { described_class.new(create(:portal_access, post_delete: true).person, master_class) }

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
    subject { described_class.new(create(:portal_access, post_export: true).person, master_class) }

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
    subject { described_class.new(create(:portal_access, post_history: true).person, master_class) }

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
  context "logged in admin with hide permission" do
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
    subject { described_class.new(create(:portal_access, post_hide: true).person, master_class) }

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
  context "logged in admin with ignore permission" do
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
    subject { described_class.new(create(:portal_access, post_ignore: true).person, master_class) }

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
      let(:portal_access) { create(:portal_access, post_hide: true) }
      subject { described_class.new(Person.find(portal_access.person_id), PostReport.new(status: :no_action_needed)) }

      it { is_expected.to permit_action(:hide_post_report_action) }
      it { is_expected.to permit_action(:reanalyze_post_report_action) }
      it { is_expected.to forbid_action(:ignore_post_report_action) }
    end
  end

  context "Logged in admin with chat ignore permission" do
    describe "message report with pending status" do
      let(:portal_access) { create(:portal_access, post_ignore: true) }
      subject { described_class.new(Person.find(portal_access.person_id), PostReport.new(status: :pending)) }

      it { is_expected.to permit_action(:ignore_post_report_action) }
      it { is_expected.to forbid_action(:hide_post_report_action) }
      it { is_expected.to forbid_action(:reanalyze_post_report_action) }
    end
  end

  context "Scope" do
    it "should only return the person quiz in current product" do
      person = build(:person)

      post2 = ActsAsTenant.with_tenant(create(:product)) { create(:post_report) }

      ActsAsTenant.with_tenant(person.product) do
        post = create(:post_report)
        scope = Pundit.policy_scope!(person, PostReport)
        expect(scope.count).to eq(1)
        expect(scope).to include(post)
        expect(scope).not_to include(post2)
      end
    end
  end
end
