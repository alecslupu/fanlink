RSpec.describe PostTag, type: :model do
  context "Validation" do
    describe "should create a valid post tag join" do
      it do
        expect(create(:post_tag)).to be_valid
      end
    end
  end
end
