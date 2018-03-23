RSpec.describe Event, type: :model do

  describe "#ends_at" do
    it "should not have an ends_at that is before the starts_at" do
      event = create(:event)
      event.ends_at = event.starts_at - 1.day
      expect(event).not_to be_valid
      expect(event.errors[:ends_at]).not_to be_empty
    end
  end

  describe "#valid?" do
    it "should create a valid event" do
      expect(create(:event)).to be_valid
    end
  end
  describe "#name" do
    it "should not allow an event without a name" do
      event = build(:event, name: nil)
      expect(event).not_to be_valid
      expect(event.errors[:name]).not_to be_blank
    end
    it "should not allow an event with a blank name" do
      event = build(:event, name: "")
      expect(event).not_to be_valid
      expect(event.errors[:name]).not_to be_blank
    end
  end

  describe "#place_identifier" do
    it "should normalize blank to nil" do
      event = create(:event, place_identifier: "")
      expect(event.place_identifier).to be_nil
    end
  end

  describe "#starts_at" do
    it "should not allow an event without a start time" do
      event = build(:event, starts_at: nil)
      expect(event).not_to be_valid
      expect(event.errors[:starts_at]).not_to be_blank
    end
  end
end
