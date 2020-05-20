# frozen_string_literal: true

require "spec_helper"

RSpec.describe PersonCertcoursePolicy, type: :policy do
  let(:master_class) { PersonCertcourse.new }
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
  context "logged in courseware with no permission" do
    subject { described_class.new(build(:person), master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:module_name)).to eq("courseware") }
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
    before :each do
      allow_any_instance_of(Person).to receive(:individual_access).and_return(build(:portal_access, courseware_read: true))
    end

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
      select_product: false
    }
before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(build(:portal_access, courseware_update: true))
      end

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
      select_product: false
    }
before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(build(:portal_access, courseware_delete: true))
      end

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
before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(build(:portal_access, courseware_export: true))
      end

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
before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(build(:portal_access, courseware_history: true))
      end

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
      let(:portal_access) { create(:portal_access, courseware_forget: true) }
      subject { described_class.new(Person.find(portal_access.person_id), MessageReport.new(status: :no_action_needed)) }

      it { is_expected.to permit_action(:forget_action) }
      it { is_expected.to forbid_action(:reset_progress_action) }
    end
  end

  context "Logged in admin with chat ignore permission" do
    describe "message report with pending status" do
      let(:portal_access) { create(:portal_access, courseware_reset: true) }
      subject { described_class.new(Person.find(portal_access.person_id), MessageReport.new(status: :pending)) }

      it { is_expected.to permit_action(:reset_progress_action) }
      it { is_expected.to forbid_action(:forget_action) }
    end
  end

  context "Scope" do
    it "should only return the person quiz in current product" do
      person = build(:person)

      post2 = ActsAsTenant.with_tenant(create(:product)) { create(:person_certcourse) }

      ActsAsTenant.with_tenant(person.product) do
        post = create(:person_certcourse)
        scope = Pundit.policy_scope!(person, PersonCertcourse)
        expect(scope.count).to eq(1)
        expect(scope).to include(post)
        expect(scope).not_to include(post2)
      end
    end
  end
end
