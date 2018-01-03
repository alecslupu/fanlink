RSpec.describe Message, type: :model do

  before(:all) do
    @product = create(:product)
    ActsAsTenant.current_tenant = @product
  end

  describe "#create" do
    it "should not let you create a message without a room" do
      message = build(:message, room: nil)
      expect(message).not_to be_valid
      expect(message.errors[:room]).not_to be_empty
    end
    it "should not let you create a message without a person" do
      message = build(:message, person: nil)
      expect(message).not_to be_valid
      expect(message.errors[:person]).not_to be_empty
    end
    it "should not let you create a message without a body" do
      message = build(:message, body: nil)
      expect(message).not_to be_valid
      expect(message.errors[:body]).not_to be_empty
    end
    it "should not let you create a message with a blank body" do
      message = build(:message, body: "")
      expect(message).not_to be_valid
      expect(message.errors[:body]).not_to be_empty
    end
  end
end