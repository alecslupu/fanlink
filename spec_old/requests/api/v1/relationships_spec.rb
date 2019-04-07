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
      expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).and_return(true)
      expect_any_instance_of(Relationship).to receive(:friend_request_received_push)
      login_as(@requester)
      post "/relationships", params: { relationship: { requested_to_id: @requested.id } }
      expect(response).to be_success
      expect(relationship_json(json["relationship"], @requester)).to be true
    end
    it "should not send a friend request to someone you have blocked" do
      expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship_count)
      requester = create(:person)
      blocked = create(:person, product: requester.product)
      requester.block(blocked)
      login_as(requester)
      post "/relationships", params: { relationship: { requested_to_id: blocked.id } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("You have blocked this person or this person has blocked you.")
    end
    it "should not send a friend request to someone who has blocked you" do
      expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship_count)
      requester = create(:person)
      blocking = create(:person, product: requester.product)
      blocking.block(requester)
      login_as(requester)
      post "/relationships", params: { relationship: { requested_to_id: blocking.id } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("You have blocked this person or this person has blocked you.")
    end
    it "should just change request to friended if to person sends a new request to from person" do
      expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).and_return(true)
      requester = create(:person)
      requested = create(:person)
      rel1 = create(:relationship, requested_by: requester, requested_to: requested)
      login_as(requested)
      post "/relationships", params: { relationship: { requested_to_id: requester.id } }
      expect(response).to be_success
      expect(Relationship.last).to eq(rel1)
      expect(rel1.reload.friended?).to be_truthy
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

  describe "#destroy" do
    it "should unfriend a friend" do
      friend = create(:person)
      rel = create(:relationship, requested_by: friend, requested_to: create(:person), status: :friended)
      login_as(friend)
      delete "/relationships/#{rel.id}"
      expect(response).to be_success
      expect(rel).not_to exist_in_database
    end
    it "should not unfriend another couple of friends" do
      imposter = create(:person)
      rel = create(:relationship, requested_by: create(:person), requested_to: create(:person), status: :friended)
      login_as(imposter)
      delete "/relationships/#{rel.id}"
      expect(response).to be_not_found
      expect(rel.reload.friended?).to be_truthy
    end
    it "should not unfriend a friend who only has a request" do
      rel = create(:relationship, requested_by: create(:person), requested_to: create(:person))
      login_as(rel.requested_to)
      delete "/relationships/#{rel.id}"
      expect(response).to be_not_found
      expect(rel.reload.requested?).to be_truthy
    end
  end

  describe "#index" do
    let!(:person1) { create(:person) }
    let!(:person2) { create(:person) }
    let!(:person3) { create(:person) }
    let!(:rel1) { create(:relationship, requested_by: person1, requested_to: person2) }
    let!(:rel2) { create(:relationship, requested_by: person1, requested_to: person3, status: :friended) }
    let!(:rel3) { create(:relationship, requested_by: person2, requested_to: person3, status: :friended) }
    let!(:rel4) { create(:relationship, requested_by: person2, requested_to: create(:person)) }
    it "should get the current relationships of other user" do
      login_as(person1)
      get "/relationships", params: { person_id: person2.id.to_s }
      expect(response).to be_success
      expect(json["relationships"].map { |r| r["id"].to_i }.sort).to eq([rel3.id])
    end
    it "should get the current and pending relationships of current user" do
      expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(person2).and_return(true)
      login_as(person2)
      get "/relationships", params: { person_id: person2.id.to_s }
      expect(response).to be_success
      expect(json["relationships"].map { |r| r["id"].to_i }.sort).to eq([rel1.id, rel3.id])
    end
    it "should get the current and pending relationships of current user with no param" do
      expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(person2).and_return(true)
      login_as(person2)
      get "/relationships"
      expect(response).to be_success
      expect(json["relationships"].map { |r| r["id"].to_i }.sort).to eq([rel1.id, rel3.id])
    end
    it "should 401 if not logged in" do
      post "/relationships"
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
      # expect(json["relationship"]).to eq(relationship_json(rel, person))
      expect(relationship_json(json["relationship"], person)).to be true
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
    it "should not get relationship if relationship denied or withdrawn or unfriended" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      rel.destroy
      get "/relationships/#{rel.id}"
      expect(response).to be_not_found
    end
  end

  describe "#update" do
    it "should accept a friend request" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      expect_any_instance_of(Relationship).to receive(:friend_request_accepted_push)
      expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(rel.requested_to)
      patch "/relationships/#{rel.id}", params: { relationship: { status: "friended" } }
      expect(response).to be_success
      expect(rel.reload.friended?).to be_truthy
      expect(relationship_json(json["relationship"], person)).to be true
    end
    it "should not accept own friend request" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_to: create(:person, product: person.product), requested_by: person)
      expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship_count)
      patch "/relationships/#{rel.id}", params: { relationship: { status: "friended" } }
      expect(response).to be_unprocessable
      expect(rel.reload.requested?).to be_truthy
    end
    it "should not accept a friend request if status not appropriate status" do
      expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship_count)
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      (Relationship.statuses.keys - ["requested", "friended"]).each do |s|
        rel.update_column(:status, s)
        patch "/relationships/#{rel.id}", params: { relationship: { status: "friended" } }
        expect(rel.reload.status).to eq(s)
      end
    end
    it "should deny a friend request" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(person).and_return(true)
      patch "/relationships/#{rel.id}", params: { relationship: { status: "denied" } }
      expect(response).to be_success
      expect(rel).not_to exist_in_database
      expect(person.reload.friend_request_count).to eq(0)
    end
    it "should withdraw a friend request" do
      person = create(:person)
      req_to = create(:person, product: person.product)
      login_as(person)
      rel = create(:relationship, requested_by: person, requested_to: req_to)
      expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(req_to).and_return(true)
      patch "/relationships/#{rel.id}", params: { relationship: { status: :withdrawn } }
      expect(response).to be_success
      expect(rel).not_to exist_in_database
    end
    it "should not update with an invalid status" do
      person = create(:person)
      login_as(person)
      rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
      patch "/relationships/#{rel.id}", params: { relationship: { status: :incestral } }
      expect(response).to be_unprocessable
      expect(rel.reload.requested?).to be_truthy
      expect(json["errors"]).to include("That status is invalid")
    end
  end

end
