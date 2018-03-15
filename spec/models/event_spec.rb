RSpec.describe Event, type: :model do

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

  describe "#start_time" do
    it "should not allow an event without a start time" do
      event = build(:event, start_time: nil)
      expect(event).not_to be_valid
      expect(event.errors[:start_time]).not_to be_blank
    end
  end

end