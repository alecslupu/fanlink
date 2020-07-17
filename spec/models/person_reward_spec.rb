# frozen_string_literal: true

# == Schema Information
#
# Table name: person_rewards
#
#  id         :bigint           not null, primary key
#  person_id  :integer          not null
#  reward_id  :integer          not null
#  source     :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted    :boolean          default(FALSE)
#


RSpec.describe PersonReward, type: :model do
  context 'Validation' do
    describe 'should create a valid person reward join' do
      it do
        expect(build(:person_reward)).to be_valid
      end
    end
  end
end
