require "rails_helper"

RSpec.describe CertcoursePolicy, type: :policy do
  subject { described_class.new(person, certcourse) }

  let(:person) { nil }

  context "CRUD actions" do
    let(:certcourse) { Certcourse.new }

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
  end

  context "Rails admin actions" do
    let(:certcourse) { Certcourse.new }

    it { is_expected.to permit_actions(%i[export history dashboard select_product_dashboard]) }
    it { is_expected.to forbid_actions(%i[show_in_app generate_game_action]) }
  end

  describe "#select_product" do
    let(:certcourse) { Certcourse.new }

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
    it "should only return certcourses pages from the current product" do
      ActsAsTenant.without_tenant do
        person = create(:person, role: :admin)
        current_product = create(:product)
        another_product = create(:product)

        certcourse = create(:certcourse, product_id: current_product.id)
        certcourse2 = create(:certcourse, product_id: current_product.id)
        create(:certcourse, product_id: another_product.id)
        expect(Certcourse.count).to eq(3) # to test if all the certcourses pages are created

        ActsAsTenant.current_tenant = current_product
        scope = Pundit.policy_scope!(person, Certcourse.all)
        expect(scope.count).to eq(2)
        expect(scope).to include(certcourse)
        expect(scope).to include(certcourse2)
      end
    end
  end
end
