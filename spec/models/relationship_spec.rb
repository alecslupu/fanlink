RSpec.describe Relationship, type: :model do

  before(:all) do
    ActsAsTenant.current_tenant = current_product
  end

  context "Associations" do
    describe "should belong to" do
      it "#requested_by" do
        should belong_to(:requested_by).class_name("Person").touch(true)
      end

      it "#requested_to" do
        should belong_to(:requested_to).class_name("Person").touch(true)
      end
    end
  end

  context "Validation" do
    describe "should create a valid relationship" do
      it do
        expect(create(:relationship)).to be_valid
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
  end

  describe ".for_people" do
    it "should get one relationship between two people" do
      rel = create(:relationship)
      relationships = Relationship.for_people(rel.requested_by, rel.requested_to)
      expect(relationships.count).to eq(1)
      expect(relationships.first).to eq(rel)
    end
  end

  #TODO this should be renamed friendships or made to return persons
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
      allowed = %i[ friended ]
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
      %i[ requested ].each do |s|
        rel.update_column(:status, Relationship.statuses[:friended])
        rel.status = s
        invalid_status(rel)
      end
    end
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
