require 'rails_helper'

RSpec.describe ActivityType, type: :model do
  it { should validate_presence_of(:activity_id) }
end
