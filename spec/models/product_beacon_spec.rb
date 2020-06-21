# frozen_string_literal: true

RSpec.describe ProductBeacon, type: :model do
  context "Validation" do
    it "should validate presence of assigned_type" do
      should validate_presence_of(:beacon_pid).with_message(_("Beacon PID is required."))
    end
  end

  context "Valid factory" do
    it { expect(build(:product_beacon)).to be_valid }
  end

  context "Associations" do
    it { should belong_to(:product) }
  end

  context "Methods" do
    describe ".attached_to" do
      it "should normalize  :attached_to" do
        product_beacon = build(:product_beacon, attached_to: " 15 ")
        expect(product_beacon.attached_to).to eq(15)
      end
    end
    describe ".uuid" do
      it "should normalize :uuid" do
        product_beacon = build(:product_beacon, uuid: " 38a95016-ba21-4b1b-94ab-7cbe276c7306 ")
        expect(product_beacon.uuid).to eq("38a95016-ba21-4b1b-94ab-7cbe276c7306")
      end
    end
    describe "#for_id_or_pid" do
      it "uses the id" do
        beacon = create(:product_beacon)
        tested = ProductBeacon.for_id_or_pid(beacon.id)
        expect(tested.count).to eq(1)
        expect(tested.first).to eq(beacon)
      end
      it "uses the beacon_pid" do
        beacon = create(:product_beacon)
        tested = ProductBeacon.for_id_or_pid(beacon.beacon_pid)
        expect(tested.count).to eq(1)
        expect(tested.first).to eq(beacon)
      end
    end
  end

  describe "should create a valid product beacon" do
    it { expect(create(:product_beacon)).to be_valid }
  end
end
