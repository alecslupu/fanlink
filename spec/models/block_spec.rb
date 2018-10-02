RSpec.describe Block, type: :model do

  before(:all) do
    ActsAsTenant.current_tenant = create(:product)
  end

  context "Validation" do
    it "should create a valid block" do
      expect(create(:block)).to be_valid
    end
  end

  describe "#blocked_id" do
    it "should not let you block someone already blocked" do
      block = create(:block)
      block2 = build(:block, blocker_id: block.blocker_id, blocked_id: block.blocked_id)
      expect(block2).not_to be_valid
    end
  end

end
