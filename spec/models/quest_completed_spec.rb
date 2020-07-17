# frozen_string_literal: true

# == Schema Information
#
# Table name: quest_completed
#
#  id         :bigint           not null, primary key
#  quest_id   :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


RSpec.describe QuestCompleted, type: :model do
  context 'Validation' do
    it 'should create a valid quest completed' do
      expect(build(:quest_completed)).to be_valid
    end
  end
end
