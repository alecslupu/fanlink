# frozen_string_literal: true

require "spec_helper"

RSpec.describe PostReportPolicy, type: :policy do
  args = PostReport, "post"

  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  # include_examples 'enforces the update permission', args
  # include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

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
      select_product: false
    }

    before :each do
      allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(post_delete: true))
    end

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
      select_product: false
    }

    before :each do
      allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(post_update: true))
    end

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

  let(:master_class) { PostReport.new }

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
    before :each do
      allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(post_hide: true))
    end
    subject { described_class.new(Person.new, master_class) }

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
    before :each do
      allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(post_ignore: true))
    end
    subject { described_class.new(Person.new, master_class) }

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
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(post_hide: true))
      end
      subject { described_class.new(Person.new, PostReport.new(status: :no_action_needed)) }

      it { is_expected.to permit_action(:hide_post_report_action) }
      it { is_expected.to permit_action(:reanalyze_post_report_action) }
      it { is_expected.to forbid_action(:ignore_post_report_action) }
    end
  end

  context "Logged in admin with chat ignore permission" do
    describe "message report with pending status" do
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(post_ignore: true))
      end
      subject { described_class.new(Person.new, PostReport.new(status: :pending)) }

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
