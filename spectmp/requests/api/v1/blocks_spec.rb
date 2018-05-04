describe "Blocks (v1)" do

  describe "#create" do
    it "should block person" do
      blocker = create(:person)
      to_be_blocked = create(:person, product: blocker.product)
      login_as(blocker)
      post "/blocks", params: { block: { blocked_id: to_be_blocked.id } }
      expect(response).to be_success
      expect(json["block"]).to eq(block_json(Block.last))
      expect(blocker.blocked?(to_be_blocked)).to be_truthy
    end
    it "should kill relationships with person" do
      blocker = create(:person)
      to_be_blocked = create(:person, product: blocker.product)
      rel1 = create(:relationship, requested_by: blocker, requested_to: to_be_blocked)
      login_as(blocker)
      post "/blocks", params: { block: { blocked_id: to_be_blocked.id } }
      expect(response).to be_success
      expect(rel1).not_to exist_in_database
    end
    it "should unfollow person" do
      blocker = create(:person)
      to_be_blocked = create(:person, product: blocker.product)
      blocker.follow(to_be_blocked)
      login_as(blocker)
      post "/blocks", params: { block: { blocked_id: to_be_blocked.id } }
      expect(response).to be_success
      expect(blocker.following?(to_be_blocked)).to be_falsey
    end
    it "should be unfollowed blocked person" do
      blocker = create(:person)
      to_be_blocked = create(:person, product: blocker.product)
      to_be_blocked.follow(blocker)
      login_as(blocker)
      post "/blocks", params: { block: { blocked_id: to_be_blocked.id } }
      expect(response).to be_success
      expect(to_be_blocked.following?(blocker)).to be_falsey
    end
    it "should not block person already blocked" do
      blocker = create(:person)
      to_be_blocked = create(:person, product: blocker.product)
      blocker.block(to_be_blocked)
      login_as(blocker)
      post "/blocks", params: { block: { blocked_id: to_be_blocked.id } }
      expect(response).to be_unprocessable
      expect(json["errors"].first).to include("already blocked")
    end
  end
  describe "#destroy" do
    it "should unblock person" do
      blocker = create(:person)
      to_be_unblocked = create(:person, product: blocker.product)
      block = blocker.block(to_be_unblocked)
      login_as(blocker)
      delete "/blocks/#{block.id}"
      expect(response).to be_success
      expect(block).not_to exist_in_database
    end
    it "should not unblock if blocker not current user" do
      blocker = create(:person)
      not_to_be_unblocked = create(:person, product: blocker.product)
      block = blocker.block(not_to_be_unblocked)
      login_as(create(:person))
      delete "/blocks/#{block.id}"
      expect(response).to be_not_found
      expect(block).to exist_in_database
    end
  end
end
