describe "Relationships (v1)" do
  before(:all) do
    @requester = create(:person)
    @requested = create(:person, product: @requester.product)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should send a friend request to someone" do
      login_as(@requester)
      post "/relationships", params: { relationship: { requested_to_id: @requested.id } }
      expect(response).to be_success
      expect(json["relationship"]).to eq(relationship_json(Relationship.last, @requester))
    end
    it "should 404 if trying to befriend someone who does not exist" do
      login_as(@requester)
      post "/relationships", params: { requested_to_id: Person.last.try(:id).to_i + 1 }
      expect(response).to be_not_found
    end
    it "should 401 if not logged in" do
      post "/relationships", params: { requested_to_id: @requested.id }
      expect(response).to be_unauthorized
    end
  end
end
