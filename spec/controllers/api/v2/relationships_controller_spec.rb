# frozen_string_literal: true
require "spec_helper"

RSpec.describe Api::V2::RelationshipsController, type: :controller do
  describe "#create" do
    it "should send a friend request to someone" do
      requester = create(:person)
      ActsAsTenant.with_tenant(requester.product) do
        login_as(requester)
        requested = create(:person)
        expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).and_return(true)
        expect_any_instance_of(Relationship).to receive(:friend_request_received_push)
        post :create, params: { relationship: { requested_to_id: requested.id } }
        expect(response).to be_successful
        expect(relationship_json(json["relationship"], requester)).to be true
      end
    end
    it "should not send a friend request to someone you have blocked" do
      requester = create(:person)
      ActsAsTenant.with_tenant(requester.product) do
        login_as(requester)
        expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship_count)
        blocked = create(:person, product: requester.product)
        requester.block(blocked)
        post :create, params: { relationship: { requested_to_id: blocked.id } }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("You have blocked this person or this person has blocked you.")
      end
    end
    it "should not send a friend request to someone who has blocked you" do
      requester = create(:person)
      ActsAsTenant.with_tenant(requester.product) do
        login_as(requester)
        expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship_count)
        blocking = create(:person, product: requester.product)
        blocking.block(requester)
        post :create, params: { relationship: { requested_to_id: blocking.id } }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("You have blocked this person or this person has blocked you.")
      end
    end
    it "should just change request to friended if to person sends a new request to from person" do
      requested = create(:person)
      ActsAsTenant.with_tenant(requested.product) do
        login_as(requested)
        expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).and_return(true)
        requester = create(:person)
        rel1 = create(:relationship, requested_by: requester, requested_to: requested)
        post :create, params: { relationship: { requested_to_id: requester.id } }
        expect(response).to be_successful
        expect(Relationship.last).to eq(rel1)
        expect(rel1.reload.friended?).to be_truthy
      end
    end
    it "should 404 if trying to befriend someone who does not exist" do
      person1 = create(:person)
      ActsAsTenant.with_tenant(person1.product) do
        login_as(person1)
        post :create, params: { relationship: { requested_to_id: Person.last.try(:id).to_i + 1 } }
        expect(response).to be_not_found
      end
    end
    it "should 401 if not logged in" do
      person1 = create(:person)
      ActsAsTenant.with_tenant(person1.product) do
        post :create, params: { relationship: { requested_to_id: person1.id } }
        expect(response).to be_unauthorized
      end
    end
  end

  describe "#destroy" do
    it "should unfriend a friend" do
      friend = create(:person)
      ActsAsTenant.with_tenant(friend.product) do
        rel = create(:relationship, requested_by: friend, requested_to: create(:person), status: :friended)
        login_as(friend)
        delete :destroy, params: { id: rel.id }
        expect(response).to be_successful
        expect(rel).not_to exist_in_database
      end
    end
    it "should not unfriend another couple of friends" do
      imposter = create(:person)
      ActsAsTenant.with_tenant(imposter.product) do
        rel = create(:relationship, requested_by: create(:person), requested_to: create(:person), status: :friended)
        login_as(imposter)
        delete :destroy, params: { id: rel.id }
        expect(response).to be_not_found
        expect(rel.reload.friended?).to be_truthy
      end
    end
    it "should not unfriend a friend who only has a request" do
      person1 = create(:person)
      ActsAsTenant.with_tenant(person1.product) do
        rel = create(:relationship, requested_by: create(:person), requested_to: person1)
        login_as(person1)
        delete :destroy, params: { id: rel.id }
        expect(response).to be_not_found
        expect(rel.reload.requested?).to be_truthy
      end
    end
  end

  describe "#index" do
    it "should get the current relationships of other user" do
      person1 = create(:person)
      ActsAsTenant.with_tenant(person1.product) do
        login_as(person1)
        person2 = create(:person)

        person3 = create(:person)
        rel3 = create(:relationship, requested_by: person2, requested_to: person3, status: :friended)

        get :index, params: { person_id: person2.id.to_s }
        expect(response).to be_successful
        expect(json["relationships"].map { |r| r["id"].to_i }.sort).to eq([rel3.id])
      end
    end
    it "should get the current and pending relationships of current user" do
      person2 = create(:person)
      ActsAsTenant.with_tenant(person2.product) do
        login_as(person2)
        person1 = create(:person)
        person3 = create(:person)

        rel1 = create(:relationship, requested_by: person1, requested_to: person2)
        rel3 = create(:relationship, requested_by: person2, requested_to: person3, status: :friended)

        expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(person2).and_return(true)
        get :index, params: { person_id: person2.id.to_s }
        expect(response).to be_successful
        expect(json["relationships"].map { |r| r["id"].to_i }.sort).to eq([rel1.id, rel3.id])
      end
    end
    it "should get the current and pending relationships of current user with no param" do
      person2 = create(:person)
      ActsAsTenant.with_tenant(person2.product) do
        login_as(person2)
        person1 = create(:person)
        person3 = create(:person)

        rel1 = create(:relationship, requested_by: person1, requested_to: person2)
        rel3 = create(:relationship, requested_by: person2, requested_to: person3, status: :friended)

        expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(person2).and_return(true)
        get :index
        expect(response).to be_successful
        expect(json["relationships"].map { |r| r["id"].to_i }.sort).to eq([rel1.id, rel3.id])
      end
    end
    it "should 401 if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        get :index
        expect(response).to be_unauthorized
      end
    end
  end

  describe "#show" do
    it "should get a single relationship" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
        get :show, params: { id: rel.id }
        expect(response).to be_successful
        # expect(json["relationship"]).to eq(relationship_json(rel, person))
        expect(relationship_json(json["relationship"], person)).to be true
      end
    end
    it "should not get relationship if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
        get :show, params: { id: rel.id }
        expect(response).to be_unauthorized
      end
    end
    it "should not get relationship if not a part of it" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(create(:person))
        rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
        get :show, params: { id: rel.id }
        expect(response).to be_not_found
      end
    end
    it "should not get relationship if relationship denied or withdrawn or unfriended" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
        rel.destroy
        get :show, params: { id: rel.id }
        expect(response).to be_not_found
      end
    end
  end

  describe "#update" do
    it "should accept a friend request" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
        expect_any_instance_of(Relationship).to receive(:friend_request_accepted_push)
        expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(rel.requested_to)
        patch :update, params: { id: rel.id, relationship: { status: "friended" } }
        expect(response).to be_successful
        expect(rel.reload.friended?).to be_truthy
        expect(relationship_json(json["relationship"], person)).to be true
      end
    end
    it "should not accept own friend request" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        rel = create(:relationship, requested_to: create(:person, product: person.product), requested_by: person)
        expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship_count)
        patch :update, params: { id: rel.id, relationship: { status: "friended" } }
        expect(response).to be_unprocessable
        expect(rel.reload.requested?).to be_truthy
      end
    end
    it "should not accept a friend request if status not appropriate status" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expect_any_instance_of(Api::V1::RelationshipsController).not_to receive(:update_relationship_count)

        rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
        (Relationship.statuses.keys - ["requested", "friended"]).each do |s|
          rel.update_column(:status, s)
          patch :update, params: { id: rel.id, relationship: { status: "friended" } }
          expect(rel.reload.status).to eq(s)
        end
      end
    end
    it "should deny a friend request" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
        expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(person).and_return(true)
        patch :update, params: { id: rel.id, relationship: { status: "denied" } }
        expect(response).to be_successful
        expect(rel).not_to exist_in_database
        expect(person.reload.friend_request_count).to eq(0)
      end
    end
    it "should withdraw a friend request" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        req_to = create(:person, product: person.product)
        rel = create(:relationship, requested_by: person, requested_to: req_to)
        expect_any_instance_of(Api::V1::RelationshipsController).to receive(:update_relationship_count).with(req_to).and_return(true)
        patch :update, params: { id: rel.id, relationship: { status: :withdrawn } }
        expect(response).to be_successful
        expect(rel).not_to exist_in_database
      end
    end
    it "should not update with an invalid status" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        rel = create(:relationship, requested_by: create(:person, product: person.product), requested_to: person)
        patch :update, params: { id: rel.id, relationship: { status: :incestral } }
        expect(response).to be_unprocessable
        expect(rel.reload.requested?).to be_truthy
        expect(json["errors"]).to include("That status is invalid")
      end
    end
  end
end
