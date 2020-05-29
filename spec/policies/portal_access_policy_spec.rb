# frozen_string_literal: true

require "spec_helper"

RSpec.describe PortalAccessPolicy, type: :policy do
  args = PortalAccess, "admin"

  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  context "Scope" do
    it "should only return the messages from public rooms" do
      person = build(:person)
      current_product = person.product
      another_product = create(:product)

      portal_access = create(:portal_access, person: person)
      portal_access2 = create(:portal_access, person: create(:person, product: another_product))

      ActsAsTenant.with_tenant(current_product) do
        scope = Pundit.policy_scope!(person, PortalAccess)
        expect(scope.count).to eq(1)
        expect(scope).to include(portal_access)
        expect(scope).not_to include(portal_access2)
      end
    end
  end
end
