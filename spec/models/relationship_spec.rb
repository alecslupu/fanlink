# frozen_string_literal: true
RSpec.describe Relationship, type: :model do

  context "Associations" do
    describe "should belong to" do
      it { should belong_to(:requested_by).class_name("Person").touch(true) }
      it { should belong_to(:requested_to).class_name("Person").touch(true) }
    end
  end

  context "Validation" do
    describe "should create a valid relationship" do
      it do
        expect(build(:relationship)).to be_valid
      end
    end
  end

  describe "#create" do
    it "should not let you create a relationship with yourself" do
      person = create(:person)
      rel = Relationship.create(requested_by: person, requested_to: person)
      expect(rel).not_to be_valid
    end
    it "should not let you create a relationship when you have outstanding request to that person" do
      rel = create(:relationship)
      expect(rel.requested?).to be_truthy
      expect(rel).to be_valid
      rel2 = build(:relationship, requested_by_id: rel.requested_by_id, requested_to_id: rel.requested_to_id)
      expect(rel2).not_to be_valid
      expect(rel2.errors[:base].first).to include("already have an existing")
    end
    it "should not let you create a relationship when you have outstanding request from that person" do
      rel = create(:relationship)
      expect(rel.requested?).to be_truthy
      rel2 = build(:relationship, requested_to_id: rel.requested_by_id, requested_by_id: rel.requested_to_id)
      expect(rel2).not_to be_valid
      expect(rel2.errors[:base].first).to include("already have an existing")
    end
    it "should not let you create a relationship when you have a friendship with that person" do
      rel = create(:relationship)
      rel.friended!
      rel2 = build(:relationship, requested_by_id: rel.requested_by_id, requested_to_id: rel.requested_to_id)
      expect(rel2).not_to be_valid
      expect(rel2.errors[:base].first).to include("already have an existing")
    end

    it "does not let you create a relationship with two people from different products" do
      person = create(:person, product: create(:product))
      person2 = create(:person, product: create(:product))
      rel = Relationship.create(requested_by: person, requested_to: person2)
      expect(rel).not_to be_valid
      expect(rel.errors[:base].first).to include("You cannot friend a person from a different product")
    end
  end

  describe ".for_people" do
    it "should get one relationship between two people" do
      rel = create(:relationship)
      relationships = Relationship.for_people(rel.requested_by, rel.requested_to)
      expect(relationships.count).to eq(1)
      expect(relationships.first).to eq(rel)
    end
  end

  describe ".person_involved?" do
    it "is checking requested by" do
      person = create(:person)
      rel = create(:relationship, requested_by: person)
      expect(rel.person_involved?(person)).to be_truthy
    end
    it "is checking requested by to be false" do
      person = create(:person)
      rel = create(:relationship)
      expect(rel.person_involved?(person)).to be_falsey
    end
    it "is checking requested to" do
      person = create(:person)
      rel = create(:relationship, requested_to: person)
      expect(rel.person_involved?(person)).to be_truthy
    end
  end
  describe ".for_person" do
    it "should get one relationship between two people" do
      rel = create(:relationship)
      relationships = Relationship.for_person(rel.requested_by)
      expect(relationships.count).to eq(1)
      expect(relationships.first).to eq(rel)
    end
    it "should get one relationship between two people" do
      rel = create(:relationship)
      relationships = Relationship.for_person(rel.requested_to)
      expect(relationships.count).to eq(1)
      expect(relationships.first).to eq(rel)
    end
  end

  # TODO this should be renamed friendships or made to return persons
  describe "#friends" do
    it "should get all friendships of a person" do
      per = create(:person)
      rel1 = create(:relationship, requested_by: per)
      rel1.friended!
      rel2 = create(:relationship, requested_to: per)
      rel2.friended!
      rel3 = create(:relationship, requested_by: per)
      fr = per.friends
      expect(fr.count).to eq(2)
      expect(fr).not_to include(fr)
    end
  end

  describe "#status" do
    it "should allow transition from requested to friended" do
      rel = create(:relationship)
      expect(rel.requested?).to be_truthy
      rel.friended!
      valid_status(rel)
      expect(rel.friended?).to be_truthy
    end
    it "should allow transitions from requested" do
      allowed = %i[friended]
      rel = create(:relationship)
      expect(rel.requested?).to be_truthy
      allowed.each do |s|
        rel.status = s
        valid_status(rel)
        rel.status = :requested
      end
    end
    it "should disallow transitions from friended" do
      rel = create(:relationship)
      %i[requested].each do |s|
        rel.update_column(:status, Relationship.statuses[:friended])
        rel.status = s
        invalid_status(rel)
      end
    end
  end
  describe "#friend_request_accepted_push" do
    it "responds to method " do
      expect(Relationship.new).to respond_to(:friend_request_accepted_push)
    end
    pending
  end
  describe "#friend_request_received_push" do
    it "responds to method " do
      expect(Relationship.new).to respond_to(:friend_request_received_push)
    end
    pending
  end

private

  def invalid_status(rel)
    expect(rel).not_to be_valid
    expect(rel.errors[:status]).not_to be_empty
  end

  def valid_status(rel)
    expect(rel).to be_valid
  end
end
