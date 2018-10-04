RSpec.describe MessageReport, type: :model do

  before(:all) do
    @product = create(:product)
    @room = create(:room, product: @product)
    @message = create(:message, room: @room)
    ActsAsTenant.current_tenant = @product
  end

  context "Valid" do
    it "should create a valid message report" do
      expect(create(:message_report)).to be_valid
    end
  end

  describe "#create" do
    it "should not let you create a message report without a message" do
      report = build(:message_report, message: nil)
      expect(report).not_to be_valid
      expect(report.errors[:message]).not_to be_empty
    end
    it "should not let you create a message report without a person" do
      report = build(:message_report, person: nil)
      expect(report).not_to be_valid
      expect(report.errors[:person]).not_to be_empty
    end
  end

  describe "#reason" do
    it "should not let you give a reason more than 500 characters in length" do
      report = build(:message_report, reason: "a" * 501)
      expect(report).not_to be_valid
      expect(report.errors[:reason]).not_to be_empty
    end
  end
end
