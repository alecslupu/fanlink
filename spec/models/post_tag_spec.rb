# frozen_string_literal: true
RSpec.describe PostTag, type: :model do
  context "Validation" do
    describe "should create a valid post tag join" do
      it do
        expect(build(:post_tag)).to be_valid
      end
    end
  end
end
