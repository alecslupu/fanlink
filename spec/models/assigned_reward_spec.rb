# frozen_string_literal: true

require "rails_helper"

RSpec.describe AssignedReward, type: :model do
  context "Validation" do
    it "should validate presence of assigned_type" do
      should validate_presence_of(:assigned_type).with_message(_(" is not an assignable type."))
      should validate_inclusion_of(:assigned_type).in_array(%w[ActionType Quest Step QuestActivity])
    end
    it "should create a valid assigned_reward" do
      expect(build(:assigned_as_quest)).to be_valid
    end
  end
  context "Associations" do
    it { should belong_to(:assigned) }
    it { should belong_to(:reward).touch(true) }
  end

  context "Valid factory" do
    it { expect(build(:assigned_reward)).not_to be_valid }
    it { expect(build(:assigned_as_quest)).to be_valid }
    it { expect(build(:assigned_as_step)).to be_valid }
    it { expect(build(:assigned_as_quest_activity)).to be_valid }
    it { expect(build(:assigned_as_action_type)).to be_valid }
  end

  # describe "scopes" do
  #   # It's a good idea to create specs that test a failing result for each scope, but that's up to you
  #   it ".loved returns all votes with a score > 0" do
  #     product = create(:product)
  #     love_vote = create(:vote, score: 1, product_id: product.id)
  #     expect(Vote.loved.first).to eq(love_vote)
  #   end
  #
  #   it "has another scope that works" do
  #     expect(model.scope_name(conditions)).to eq(result_expected)
  #   end
  # end
end
