RSpec.describe PostReaction, type: :model do

  before(:all) do
    @product = create(:product)
    ActsAsTenant.current_tenant = @product
    @post = create(:post)
  end

  describe "#create" do
    it "should react to a post" do
      expect(create(:post_reaction)).to be_valid
    end
    it "should not let you create a post reaction without a post" do
      reaction = build(:post_reaction, post: nil)
      expect(reaction).not_to be_valid
      expect(reaction.errors[:post]).not_to be_empty
    end
    it "should not let you create a post reaction without a person" do
      reaction = build(:post_reaction, person: nil)
      expect(reaction).not_to be_valid
      expect(reaction.errors[:person]).not_to be_empty
    end
  end
end
