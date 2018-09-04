require 'rails_helper'

RSpec.describe QuestCompleted, type: :model do
  it { should validate_presence_of(:quest_id) }
end
