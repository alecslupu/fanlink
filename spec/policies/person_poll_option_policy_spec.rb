require "rails_helper"

RSpec.describe PersonPollOptionPolicy, type: :policy do
  subject { described_class.new(person, person_poll_option) }

  let(:person) { nil }

  context "CRUD actions" do
    let(:person_poll_option) { PersonPollOption.new }

    it { is_expected.to permit_actions(%i[index show ]) }
    it { is_expected.to forbid_actions(%i[new create update edit destroy]) }
  end

  context "Rails admin actions" do
    let(:person_poll_option) { PersonPollOption.new }

    it { is_expected.to permit_actions(%i[export history dashboard select_product_dashboard]) }
    it { is_expected.to forbid_actions(%i[show_in_app generate_game_action]) }
  end

  describe "#select_product" do
    let(:person_poll_option) { PersonPollOption.new }

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

        poll = create(:poll, product_id: current_product.id)
        poll2 = create(:poll, product_id: another_product.id)

        poll_option = create(:poll_option, poll_id: poll.id)
        poll_option2 = create(:poll_option, poll_id: poll.id)
        poll_option3 = create(:poll_option, poll_id: poll2.id)

        person_poll_option = create(:person_poll_option, poll_option_id: poll_option.id, person_id: person.id)
        person_poll_option2 = create(:person_poll_option,  poll_option_id: poll_option2.id, person_id: person.id)
        create(:person_poll_option,  poll_option_id: poll_option3.id, person_id: person2.id)

        expect(PersonPollOption.count).to eq(3) # to test if all the person poll options are created

        ActsAsTenant.current_tenant = current_product
        scope = Pundit.policy_scope!(person, PersonPollOption.all)

        expect(scope.count).to eq(2)
        expect(scope).to include(person_poll_option)
        expect(scope).to include(person_poll_option2)
      end
    end
  end
end
