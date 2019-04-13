RSpec.describe PortalNotification, type: :model do
  before(:all) do
    @product = Product.first || create(:product)
    ActsAsTenant.current_tenant = @product
    @person = create(:person)
  end
  context "Valid" do
    it "should create a valid portal notification" do
      expect(create(:portal_notification)).to be_valid
    end
  end

  # describe "#create" do
  #   it "should create and save a valid notification" do
  #     expect(create(:portal_notification, product: @product)).to be_valid
  #   end
  # end

  describe "#body" do
    it "should not create a notification without a body" do
      notif = build(:portal_notification, body: nil)
      expect(notif).not_to be_valid
      expect(notif.errors[:body]).not_to be_empty
    end
    it "should not create a notification with a body that is too short" do
      notif = build(:portal_notification, body: "AB")
      expect(notif).not_to be_valid
      expect(notif.errors[:body]).not_to be_empty
    end
    it "should not create a notification with a body that is too long" do
      notif = build(:portal_notification, body: "A" * 201)
      expect(notif).not_to be_valid
      expect(notif.errors[:body]).not_to be_empty
    end
  end

  describe "#send_me_at" do
    it "should not create a notification without a send_me_at time" do
      notif = build(:portal_notification, send_me_at: nil)
      expect(notif).not_to be_valid
      expect(notif.errors[:send_me_at]).not_to be_empty
    end
    it "should not allow a send_me_at before create time" do
      notif = build(:portal_notification, send_me_at: Time.now - 1.second)
      expect(notif).not_to be_valid
      expect(notif.errors[:send_me_at]).not_to be_empty
    end
  end
end
