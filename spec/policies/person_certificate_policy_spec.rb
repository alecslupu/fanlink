require "rails_helper"

RSpec.describe PersonCertificatePolicy, type: :policy do
  subject { described_class.new(person, person_certificate) }

  let(:person) { nil }

  context "CRUD actions" do
    let(:person_certificate) { PersonCertificate.new }

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
  end

  context "Rails admin actions" do
    let(:person_certificate) { PersonCertificate.new }

    it { is_expected.to permit_actions(%i[export history dashboard select_product_dashboard]) }
    it { is_expected.to forbid_actions(%i[show_in_app generate_game_action]) }
  end

  describe "#select_product" do
    let(:person_certificate) { PersonCertificate.new }

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
    it "should only return person certificates for the people that are on the current product" do
      ActsAsTenant.without_tenant do
        current_product = create(:product)
        another_product = create(:product)
        person = create(:person, role: :admin, product_id: current_product.id)
        person2 = create(:person, role: :admin, product_id: another_product.id)

        certificate = create(:certificate, product_id: current_product.id)
        certificate2 = create(:certificate, product_id: current_product.id)
        certificate3 = create(:certificate, product_id: another_product.id)
        person_certificate = create(:person_certificate, certificate_id: certificate.id, person_id: person.id)
        person_certificate2 = create(:person_certificate, certificate_id: certificate2.id, person_id: person.id)
        create(:person_certificate, certificate_id: certificate3.id, person_id: person2.id)
        expect(PersonCertificate.count).to eq(3) # to test if all the person certificates pages are created

        ActsAsTenant.current_tenant = current_product
        scope = Pundit.policy_scope!(person, PersonCertificate.all)
        expect(scope.count).to eq(2)
        expect(scope).to include(person_certificate)
        expect(scope).to include(person_certificate2)
      end
    end
  end
end
