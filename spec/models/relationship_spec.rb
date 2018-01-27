RSpec.describe Relationship, type: :model do

  before(:all) do
    ActsAsTenant.current_tenant = current_product
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
    it "should get one relationship between two people with no specified limit" do
      pending "do this one"
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
    it "should not allow transition from requested to unfriended" do
      rel = create(:relationship)
      expect(rel.requested?).to be_truthy
      rel.status = :unfriended
      invalid_status(rel)
    end
    it "should allow transitions from requested" do
      allowed = %i[ friended denied withdrawn ]
      rel = create(:relationship)
      expect(rel.requested?).to be_truthy
      allowed.each do |s|
        rel.status = s
        valid_status(rel)
        rel.status = :requested
      end
    end
    it "should disallow transitions from denied withdrawn and unfriended" do
      %i[ denied withdrawn unfriended ].each do |s|
        rel = create(:relationship)
        rel.update_column(:status, Relationship.statuses[s])
        Relationship.statuses.keys.each do |ss|
          unless s == ss.to_sym
            rel.status = ss
            invalid_status(rel)
            rel.status = s
          end
        end
      end
    end
    it "should disallow transitions from friended" do
      rel = create(:relationship)
      %i[ requested denied withdrawn ].each do |s| # all but unfriended
        rel.update_column(:status, Relationship.statuses[:friended])
        rel.status = s
        invalid_status(rel)
      end
    end
    it "should allow transitions from friended to unfriended" do
      rel = create(:relationship)
      rel.update_column(:status, Relationship.statuses[:friended])
      rel.status = :unfriended
      valid_status(rel)
    end
  end

  describe "#valid?" do
    it "should be valid" do
      expect(create(:relationship).valid?).to be_truthy
    end
  end

  describe ".visible" do
    it "should be visible if requested" do
      rel = create(:relationship)
      expect(Relationship.visible).to include(rel)
    end
    it "should be visible if friended" do
      rel = create(:relationship)
      rel.friended!
      expect(Relationship.visible).to include(rel)
    end
    it "should not be visible" do
      rel = create(:relationship)
      %i[ denied withdrawn ].each do |s|
        rel.update_column(:status, s)
        expect(Relationship.visible).not_to include(rel)
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
