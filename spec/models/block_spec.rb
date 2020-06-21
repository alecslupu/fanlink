# frozen_string_literal: true

RSpec.describe Block, type: :model do

  context "Validation" do
    it { expect(build(:block)).to be_valid }
  end

  describe "#blocked_id" do
    it "should not let you block someone already blocked" do
      block = create(:block)
      block2 = build(:block, blocker_id: block.blocker_id, blocked_id: block.blocked_id)
      expect(block2).not_to be_valid
    end
  end
end
