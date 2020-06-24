# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MessagePolicy, type: :policy do
  args = Message, 'chat'
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  # include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
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
    describe 'hidden message' do
      let(:portal_access) { create(:portal_access, chat_hide: true) }
      subject { described_class.new(Person.find(portal_access.person_id), Message.new(hidden: true)) }

      it { is_expected.to permit_action(:unhide_action) }
      it { is_expected.to forbid_action(:hide_action) }
    end

    describe 'visible message' do
      let(:portal_access) { create(:portal_access, chat_hide: true) }
      subject { described_class.new(Person.find(portal_access.person_id), Message.new(hidden: false)) }

      it { is_expected.to permit_action(:hide_action) }
      it { is_expected.to forbid_action(:unhide_action) }
    end
  end

  context 'Scope' do
    it 'should only return the messages from public rooms' do
      person = build(:person)

      ActsAsTenant.with_tenant(person.product) do
        current_product = create(:product)
        another_product = create(:product)

        public_room = create(:room, public: true)
        private_room = create(:room)

        message = create(:message, room: public_room)
        message2 = create(:message, room: public_room)
        create(:message, room: private_room)

        scope = Pundit.policy_scope!(person, Message)
        expect(scope.count).to eq(2)
        expect(scope).to include(message)
        expect(scope).to include(message2)
      end
    end
  end
end
