describe "NotificationDeviceIds (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should insert a new device id" do
      person = create(:person, product: @product)
      did = "dfadfa"
      login_as(person)
      post "/notification_device_ids", params: { device_id: did }
      expect(response).to be_success
      expect(person.notification_device_ids.where(device_identifier: did).exists?).to be_truthy
    end
    it "should not insert a new device id if not logged in" do
      person = create(:person, product: @product)
      did = "fkafkaf"
      post "/notification_device_ids", params: { device_id: did }
      expect(response).to be_unauthorized
      expect(person.notification_device_ids.where(device_identifier: did).exists?).to be_falsey
    end
    it "should not insert a duplicate device id" do
      person = create(:person, product: @product)
      did = "fkafkaf"
      create(:notification_device_id, person: person, device_identifier: did)
      login_as(person)
      post "/notification_device_ids", params: { device_id: did }
      expect(response).to be_unprocessable
      expect(json["errors"].first).to include("already registered")
    end
  end
end
