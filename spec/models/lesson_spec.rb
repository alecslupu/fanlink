RSpec.describe Lesson, type: :model do
  context "Validation" do
    describe "should create a valid lesson" do
      it { expect(create(:lesson)).to be_valid }
    end
  end
end
