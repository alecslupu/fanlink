# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RelationshipPolicy, type: :policy do
  args = Relationship, 'user'
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  context 'Scope' do
    it 'should only return the relationsips in current product' do
      person = create(:person)

      relationship2 = ActsAsTenant.with_tenant(create(:product)) { create(:relationship) }

      ActsAsTenant.with_tenant(person.product) do
        relationship = create(:relationship)
        scope = Pundit.policy_scope!(person, Relationship)
        expect(scope.count).to eq(1)
        expect(scope).to include(relationship)
        expect(scope).not_to include(relationship2)
      end
    end
  end
end
