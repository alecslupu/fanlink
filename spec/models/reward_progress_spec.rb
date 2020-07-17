# frozen_string_literal: true

# == Schema Information
#
# Table name: reward_progresses
#
#  id         :bigint           not null, primary key
#  reward_id  :integer          not null
#  person_id  :integer          not null
#  series     :text
#  actions    :jsonb            not null
#  total      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


RSpec.describe RewardProgress, type: :model do
  context 'Associations' do
    describe 'should belong to' do
      it '#person' do
        should belong_to(:person).touch(true)
      end

      it '#reward' do
        should belong_to(:reward)
      end
    end
  end

  context 'Validation' do
    describe 'should create a valid reward progress' do
      it do
        expect(build(:reward_progress)).to be_valid
      end
    end
  end
end
