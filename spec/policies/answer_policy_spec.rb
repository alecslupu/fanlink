# frozen_string_literal: true

require "rails_helper"

RSpec.describe AnswerPolicy, type: :policy do
  permission_list = {
    index: false,
    show: false,
    create: false,
    new: false,
    update: false,
    edit: false,
    destroy: false,
    export: false,
    history: false,
    show_in_app: false,
    dashboard: false,
    # select_product_dashboard: false,
    select_product: false,
  }

  describe "defined policies" do
    subject { described_class.new(Person.new, Answer.new) }

    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end

  context "logged out user" do
    subject { described_class.new(nil, Answer.new) }

    describe "permissions" do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe "protected methods" do
      it do
        expect(subject.send(:module_name)).to eq("courseware")
      end
      it do
        expect(subject.send(:super_admin?)).to be_nil
      end
      it do
        expect(subject.send(:has_permission?, "bogous")).to eq(false)
      end
    end
  end

  context "user with super admin role and with admin product" do
    let(:product) { create(:product, internal_name: "admin") }
    subject { described_class.new(Person.new(role: :super_admin, product: product), Answer.new) }

    describe "permissions" do
      permission_list.each do |policy, _|
        it { is_expected.to permit_action(policy) } unless policy == :show_in_app
      end

      it { is_expected.to forbid_action(:show_in_app) }
    end

    describe "protected methods" do
      it do
        expect(subject.send(:module_name)).to eq("courseware")
      end
      it do
        expect(subject.send(:super_admin?)).to eq(true)
      end
      it do
        expect(subject.send(:has_permission?, "bogous")).to eq(true)
      end
    end
  end

  context "Scope" do
    it "should return all the answers records that are for the current product" do
      person = create(:person, role: :admin)

      ActsAsTenant.with_tenant(person.product) do
        current_product = create(:product)

        answer = create(:answer)
        answer = create(:answer, product: current_product)  # only one question will be on the current_product
        expect(Answer.count).to eq(10) # there are 5 questions created for each create
                                       # 4 from the creation of the quiz page and 1 separate
        expect(Answer.where(product_id: current_product.id).count).to eq(1)
        answer_current_product = Answer.where(product_id: current_product.id).first

        scope = Pundit.policy_scope!(Person.new, Answer.all)
        expect(scope.count).to eq(1)
        expect(scope).to include(answer_current_product)
      end
    end
  end
end
