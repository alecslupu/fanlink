# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActsAsTaggableOn::TagPolicy, type: :policy do
  args = ActsAsTaggableOn::Tag, 'root'
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  # include_examples 'enforces the history permission', args
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
      allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(root_history: true))
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
end
