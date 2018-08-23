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

  describe "#person" do
    it "should not let a person react more than once" do
      reaction = create(:post_reaction)
      rereaction = build(:post_reaction, person: reaction.person, post: reaction.post)
      expect(rereaction).not_to be_valid
      expect(rereaction.errors[:person]).not_to be_empty
    end
  end
  describe "#reaction" do
    it "should require a valid emoji sequence" do
      nonemoji = "-1"
      reaction = build(:post_reaction, reaction: nonemoji)
      expect(reaction).not_to be_valid
      expect(reaction.errors[:reaction]).not_to be_empty
      nonemoji = "11FFFF"
      reaction = build(:post_reaction, reaction: nonemoji)
      expect(reaction).not_to be_valid
      expect(reaction.errors[:reaction]).not_to be_empty
    end
  end
end
