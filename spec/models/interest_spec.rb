# frozen_string_literal: true
RSpec.describe Interest, type: :model do
  context "Validation" do
    describe "should create a valid Interest" do
      it { expect(build(:interest)).to be_valid }
    end
  end
end
