# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FollowingPolicy, type: :policy do
  args = Following, 'user'

  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  context 'Scope' do
    it 'should only return the followings in current product' do
      person = create(:person)

      following2 = ActsAsTenant.with_tenant(create(:product)) { create(:following) }

      ActsAsTenant.with_tenant(person.product) do
        following = create(:following)
        scope = Pundit.policy_scope!(person, Following)
        expect(scope.count).to eq(1)
        expect(scope).to include(following)
        expect(scope).not_to include(following2)
      end
    end
  end
end
