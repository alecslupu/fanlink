# frozen_string_literal: true

require "rails_helper"

RSpec.describe AssignedRewardPolicy, type: :policy do
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
    let(:assigned_reward) { AssignedReward.create }

    subject { described_class.new(Person.new, assigned_reward) }

    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end

  context "logged out user" do
    let(:assigned_reward) { AssignedReward.create }
    subject { described_class.new(nil, assigned_reward) }

    describe "permissions" do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe "protected methods" do
      it do
        expect(subject.send(:module_name)).to eq("reward")
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
    let(:assigned_reward) { AssignedReward.create }
    subject { described_class.new(Person.new(role: :super_admin, product: product), assigned_reward) }

    describe "permissions" do
      permission_list.each do |policy, _|
        it { is_expected.to permit_action(policy) } unless policy == :show_in_app
      end

      it { is_expected.to forbid_action(:show_in_app) }
    end

    describe "protected methods" do
      it do
        expect(subject.send(:module_name)).to eq("reward")
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
    it "should return all the assigned_rewards" do
      ActsAsTenant.without_tenant do
        person = create(:person, role: :admin)

        badge = create(:badge)
        badge2 = create(:badge)

        reward = create(:reward, reward_type_id: badge.id)
        reward2 = create(:reward, reward_type_id: badge2.id)

        assigned_reward = create(:assigned_reward, reward: reward, assigned_id: 1, assigned_type: "ActionType")
        assigned_reward2 = create(:assigned_reward, reward: reward2, assigned_id: 1, assigned_type: "ActionType")

        expect(AssignedReward.count).to eq(2)

        ActsAsTenant.current_tenant = current_product
        scope = Pundit.policy_scope!(person, AssignedReward.all)
        expect(scope.count).to eq(2)
        expect(scope).to include(assigned_reward)
        expect(scope).to include(assigned_reward2)
      end
    end
  end
end
