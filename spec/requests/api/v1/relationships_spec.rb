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
      expect_any_instance_of(Api::V1::RelationshipsController).to receive(:post_relationship).and_return(true)
      login_as(@requester)
      post "/relationships", params: { relationship: { requested_to_id: @requested.id } }
      expect(response).to be_success
      expect(json["relationship"]).to eq(relationship_json(Relationship.last, @requester))
    end
    it "should 404 if trying to befriend someone who does not exist" do
      login_as(@requester)
      post "/relationships", params: { relationship: { requested_to_id: Person.last.try(:id).to_i + 1 } }
      expect(response).to be_not_found
    end
    it "should 401 if not logged in" do
      post "/relationships", params: { relationship: { requested_to_id: @requested.id } }
      expect(response).to be_unauthorized
    end
  end

  describe "#show" do
    it "should get a single relationship" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      get "/relationships/#{rel.id}"
      expect(response).to be_success
      expect(json["relationship"]).to eq(relationship_json(rel, person))
    end
    it "should not get relationship if not logged in" do
      person = create(:person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      get "/relationships/#{rel.id}"
      expect(response).to be_unauthorized
    end
    it "should not get relationship if not a part of it" do
      person = create(:person)
      login_as(create(:person))
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      get "/relationships/#{rel.id}"
      expect(response).to be_not_found
    end
    it "should not get relationship if relationship denied" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      rel.denied!
      get "/relationships/#{rel.id}"
      expect(response).to be_not_found
    end
    it "should not get relationship if relationship withdrawn" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      rel.withdrawn!
      get "/relationships/#{rel.id}"
      expect(response).to be_not_found
    end
    it "should get relationship if relationship unfriended" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      rel.update_column(:status, :unfriended)
      get "/relationships/#{rel.id}"
      expect(response).to be_success
      expect(json["relationship"]).to eq(relationship_json(rel, person))
    end
  end

  describe "#update" do
    it "should accept a friend request" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship).
          with(rel, rel.requested_by).and_return(true)
      patch "/relationships/#{rel.id}", params: { relationship: { status: :friended } }
      expect(response).to be_success
      expect(rel.reload.friended?).to be_truthy
      expect(json["relationship"]).to eq(relationship_json(rel, person))
    end
    it "should not accept own friend request" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_to: create(:person, product: person.product), requested_by: person)
      expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship)
      patch "/relationships/#{rel.id}", params: { relationship: { status: :friended } }
      expect(response).to be_unprocessable
      expect(rel.reload.requested?).to be_truthy
    end
    it "should not accept a friend request if status not appropriate status" do
      expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship)
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      (Relationship.statuses.keys - ["requested", "friended"]).each do |s|
        rel.update_column(:status, s)
        patch "/relationships/#{rel.id}", params: { relationship: { status: :friended } }
        expect(rel.reload.status).to eq(s)
      end
    end
    it "should deny a friend request" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship)
      patch "/relationships/#{rel.id}", params: { relationship: { status: :denied } }
      expect(response).to be_success
      expect(rel.reload.denied?).to be_truthy
      expect(json["relationship"]).to eq(relationship_json(rel, person))
    end
  end

end
