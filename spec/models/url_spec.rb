# frozen_string_literal: true

RSpec.describe Url, type: :model do
  context 'Associations' do
    describe 'should belong to' do
      it '#product' do
        should belong_to(:product)
      end
    end

    describe 'should have one' do
      it '#reward' do
        should have_one(:reward)
          .conditions("rewards.reward_type = #{Reward.reward_types["url"]}")
          .with_foreign_key(:reward_type_id)
      end
    end

    describe 'should have many' do
      it '#assigned_rewards' do
        should have_many(:assigned_rewards)
      end
    end
  end

  context 'Validation' do
    describe 'should create a valid url' do
      it do
        expect(build(:url)).to be_valid
      end
    end
  end
end
