require "rails_helper"

RSpec.describe PersonCertcoursePolicy, type: :policy do
  subject { described_class.new(person, person_certcourse) }

  let(:person) { nil }

  context "CRUD actions" do
    let(:person_certcourse) { PersonCertcourse.new }

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
  end

  context "Rails admin actions" do
    let(:person_certcourse) { PersonCertcourse.new }

    it { is_expected.to permit_actions(%i[export history dashboard select_product_dashboard]) }
    it { is_expected.to forbid_actions(%i[show_in_app generate_game_action]) }
  end

  describe "#select_product" do
    let(:person_certcourse) { PersonCertcourse.new }

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

  context "#forget_action" do
    let(:person_certcourse) { PersonCertcourse.new }
    it { is_expected.to permit_action(:forget_action) }
  end

  context "#reset_progress_action" do
    let(:person_certcourse) { PersonCertcourse.new }
    it { is_expected.to permit_action(:reset_progress_action) }
  end

  context "Scope" do
    it "should only return person certcourses for the people that are on the current product" do
      ActsAsTenant.without_tenant do
        current_product = create(:product)
        another_product = create(:product)
        person = create(:person, role: :admin, product_id: current_product.id)
        person2 = create(:person, role: :admin, product_id: another_product.id)

        certcourse = create(:certcourse, product_id: current_product.id)
        certcourse2 = create(:certcourse, product_id: current_product.id)
        certcourse3 = create(:certcourse, product_id: another_product.id)
        person_certcourse = create(:person_certcourse, certcourse_id: certcourse.id, person_id: person.id)
        person_certcourse2 = create(:person_certcourse, certcourse_id: certcourse2.id, person_id: person.id)
        create(:person_certcourse, certcourse_id: certcourse3.id, person_id: person2.id)
        expect(PersonCertcourse.count).to eq(3) # to test if all the person certcourses pages are created

        ActsAsTenant.current_tenant = current_product
        scope = Pundit.policy_scope!(person, PersonCertcourse.all)
        expect(scope.count).to eq(2)
        expect(scope).to include(person_certcourse)
        expect(scope).to include(person_certcourse2)
      end
    end
  end
end
