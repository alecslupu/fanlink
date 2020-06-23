# frozen_string_literal: true

RSpec.describe LevelProgress, type: :model do
  context 'Valid' do
    it { expect(build(:level_progress)).to be_valid }
  end
end
