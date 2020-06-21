# frozen_string_literal: true

require "spec_helper"

RSpec.describe PersonCertificatePolicy, type: :policy do
  args = PersonCertificate, "courseware"

  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  context "Scope" do
    it "should only return the certificate in current product" do
      person = build(:person)

      post2 = ActsAsTenant.with_tenant(create(:product)) { create(:person_certificate) }

      ActsAsTenant.with_tenant(person.product) do
        post = create(:person_certificate)
        scope = Pundit.policy_scope!(person, PersonCertificate)
        expect(scope.count).to eq(1)
        expect(scope).to include(post)
        expect(scope).not_to include(post2)
      end
    end
  end
end
