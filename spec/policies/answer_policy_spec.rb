require 'rails_helper'

RSpec.describe AnswerPolicy, type: :policy do
  subject { described_class.new(person, answer) }

  let(:person) { nil }

  context "CRUD actions" do
    let(:answer) { Answer.new }

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
  end

  context "Rails admin actions" do
    let(:answer) { Answer.new }

    it { is_expected.to permit_actions(%i[export history dashboard select_product_dashboard]) }
    it { is_expected.to forbid_actions(%i[show_in_app generate_game_action]) }
  end

  context "Rails admin actions" do
    let(:answer) { Answer.new }

    it { is_expected.to permit_actions(%i[export history dashboard select_product_dashboard]) }
    it { is_expected.to forbid_actions(%i[show_in_app generate_game_action]) }
  end

  describe "#select_product" do
    let(:answer) { Answer.new }

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
end
