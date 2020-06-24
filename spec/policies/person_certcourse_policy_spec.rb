# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PersonCertcoursePolicy, type: :policy do
  args = PersonCertcourse, 'courseware'

  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  let(:master_class) { PersonCertcourse.new }
  subject { described_class.new(Person.new, master_class) }

  context 'Logged in admin with courseware_forget permission' do
    describe 'message report with no action needed status' do
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access)
          .and_return(PortalAccess.new(courseware_forget: true))
      end

      it { is_expected.to permit_action(:forget_action) }
      it { is_expected.to forbid_action(:reset_progress_action) }
    end
  end

  context 'Logged in admin with courseware_reset permission' do
    describe 'message report with pending status' do
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access)
          .and_return(PortalAccess.new(courseware_reset: true))
      end

      it { is_expected.to permit_action(:reset_progress_action) }
      it { is_expected.to forbid_action(:forget_action) }
    end
  end

  context 'Scope' do
    it 'should only return the person quiz in current product' do
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
