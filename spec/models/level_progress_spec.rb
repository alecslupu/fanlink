# frozen_string_literal: true

# == Schema Information
#
# Table name: level_progresses
#
#  id        :bigint           not null, primary key
#  person_id :integer          not null
#  points    :jsonb            not null
#  total     :integer          default(0), not null
#


RSpec.describe LevelProgress, type: :model do
  context 'Valid' do
    it { expect(build(:level_progress)).to be_valid }
  end
end
