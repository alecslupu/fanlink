RSpec.describe Following, type: :model do
  before(:all) do
    @follower = create(:person)
    @followed = create(:person, product: @follower.product)
    @following = Following.new(follower_id: @follower.id, followed_id: @followed.id)
    ActsAsTenant.current_tenant = @follower.product
  end

  context "Valid" do
    it { expect(create(:following)).to be_valid }
  end

  describe "#follower_id" do
    it "should require a follower_id" do
      @following.follower_id = nil
      expect(@following).not_to be_valid
    end
  end

  describe "#followed_id" do
    it "should require a followed_id" do
      @following.followed_id = nil
      expect(@following).not_to be_valid
    end
  end
end
