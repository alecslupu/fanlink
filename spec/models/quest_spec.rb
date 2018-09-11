require 'rails_helper'

RSpec.describe Quest, type: :model do
  context "Validation" do
    #subject { build(:quest) }
    it do
      should validate_presence_of(:product).with_message("must exist")
      should validate_presence_of(:name).with_message("Name is required.")
      should validate_presence_of(:description).with_message("A quest description is required.")
      should validate_presence_of(:starts_at).with_message("Starting date and time is required.")
    end
  end
end
