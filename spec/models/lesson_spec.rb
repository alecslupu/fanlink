# frozen_string_literal: true

RSpec.describe Lesson, type: :model do
  context "Validation" do
    describe "should create a valid lesson" do
      it { expect(build(:lesson)).to be_valid }
    end
  end
end
