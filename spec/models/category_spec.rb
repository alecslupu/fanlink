# frozen_string_literal: true

RSpec.describe Category, type: :model do
  context "Validation" do
    describe "should create a valid category" do
      it { expect(build(:category)).to be_valid }
    end
  end
end
