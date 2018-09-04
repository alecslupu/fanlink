require 'rails_helper'

RSpec.describe Quest, type: :model do
  it { should validate_presence_of(:product_id) }
end
