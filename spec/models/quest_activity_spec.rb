require 'rails_helper'

RSpec.describe QuestActivity, type: :model do
  it { should validate_presence_of(:step_id) }
end
