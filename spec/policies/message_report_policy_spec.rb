# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MessageReportPolicy, type: :policy do
  args = MessageReport, 'chat'
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  # include_examples 'enforces the update permission', args
  # include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  context 'logged in admin with update permission' do
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
      allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(chat_delete: true))
    end

    describe 'permissions' do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe 'protected methods' do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, 'bogous')).to eq(false) }
      it { expect(subject.send(:has_permission?, 'index')).to eq(false) }
    end
  end

  context 'logged in admin with update permission' do
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
      allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(chat_update: true))
    end

    describe 'permissions' do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe 'protected methods' do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, 'bogous')).to eq(false) }
      it { expect(subject.send(:has_permission?, 'index')).to eq(false) }
    end
  end

  context 'Logged in admin with chat_hide permission' do
    describe 'message report with no action needed status' do
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(chat_hide: true))
      end
      subject { described_class.new(Person.new, MessageReport.new(status: :no_action_needed)) }

      it { is_expected.to permit_action(:hide_message_action) }
      it { is_expected.to permit_action(:reanalyze_message_action) }
      it { is_expected.to forbid_action(:ignore_message_action) }
    end
  end

  context 'Logged in admin with chat ignore permission' do
    describe 'message report with pending status' do
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(chat_ignore: true))
      end
      subject { described_class.new(Person.new, MessageReport.new(status: :pending)) }

      it { is_expected.to permit_action(:ignore_message_action) }
      it { is_expected.to forbid_action(:hide_message_action) }
      it { is_expected.to forbid_action(:reanalyze_message_action) }
    end
  end

  context 'Scope' do
    it 'should only return the messages from public rooms' do
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


