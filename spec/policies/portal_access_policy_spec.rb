require "rails_helper"

RSpec.describe PortalAccessPolicy, type: :policy do
  subject { described_class.new(person, portal_access) }

  let(:person) { nil }

  context "CRUD actions" do
    let(:portal_access) { PortalAccess.new }

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
  end

  context "Rails admin actions" do
    let(:portal_access) { PortalAccess.new }

    it { is_expected.to permit_actions(%i[export history dashboard select_product_dashboard]) }
    it { is_expected.to forbid_actions(%i[show_in_app generate_game_action]) }
  end

  describe "#select_product" do
    let(:portal_access) { PortalAccess.new }

    context "superadmin who has the admin product assigned" do
      let(:product) { create(:product, internal_name: "admin") }
      let(:person) { Person.new(product: product, role: :super_admin) }

      it { is_expected.to permit_action(:select_product) }
    end

    context "admin who has the admin product assigned" do
      let(:product) { create(:product, internal_name: "admin") }
      let(:person) { Person.new(product: product, role: :admin) }

      it { is_expected.to forbid_action(:select_product) }
    end

    context "superadmin who doesn't have admin product assigned" do
      let(:product) { create(:product, internal_name: "not_admin") }
      let(:person) { Person.new(product: product, role: :super_admin) }

      it { is_expected.to forbid_action(:select_product) }
    end
  end

  context "Scope" do
    it "should only return person quizzes for the people that are on the current product" do
      ActsAsTenant.without_tenant do
        binding.pry
        current_product = create(:product)
        another_product = create(:product)
        person = create(:person, role: :admin, product_id: current_product.id)
        person2 = create(:person, role: :admin, product_id: another_product.id)

        portal_access = create(:portal_access, person_id: person.id)
        portal_access2 = create(:portal_access, person_id: person.id)
        create(:portal_access, person_id: person2.id)
        expect(PortalAccess.count).to eq(3) # to test if all the person certificates pages are created

        ActsAsTenant.current_tenant = current_product
        scope = Pundit.policy_scope!(person, PortalAccess.all)
        expect(scope.count).to eq(2)
        expect(scope).to include(portal_access)
        expect(scope).to include(portal_access2)
      end
    end
  end
end
