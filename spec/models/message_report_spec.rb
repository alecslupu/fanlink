RSpec.describe MessageReport, type: :model do

  before(:all) do
    @product = create(:product)
    @room = create(:room, product: @product)
    @message = create(:message, room: @room)
    ActsAsTenant.current_tenant = @product
  end

  context "Associations" do
    it { should belong_to(:message) }
    it { should belong_to(:person) }
  end
  context "Validation" do
    subject { create(:message_report) }
    it { is_expected.to define_enum_for(:status).with(MessageReport.statuses.keys) }
    it { should validate_length_of(:reason).is_at_most(500).with_message(_("Reason cannot be longer than 500 characters.")) }

    context "validates inclusion" do
      it do
        MessageReport.statuses.keys.each do |status|
          expect(build(:message_report, status: status)).to be_valid
        end

        expect{ build(:message_report, status: :invalid_status_form_spec) }.to raise_error(/is not a valid status/)
      end
    end

  end

  describe "scopes" do
    # It's a good idea to create specs that test a failing result for each scope, but that's up to you
    it ".for product" do
      product = create(:product)
    end
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

  describe 'valid_status?' do
    it {expect(MessageReport.valid_status?("pending")).to be_truthy }
    it {expect(MessageReport.valid_status?('no_action_needed')).to be_truthy }
    it {expect(MessageReport.valid_status?('message_hidden')).to be_truthy }
    it {expect(MessageReport.valid_status?('no_status')).to be_falsey }
  end
end
