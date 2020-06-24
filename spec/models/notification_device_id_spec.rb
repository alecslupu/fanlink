# frozen_string_literal: true

RSpec.describe NotificationDeviceId, type: :model do
  # before(:each) do
  #   @product = create(:product)
  #   ActsAsTenant.current_tenant = @product
  # end

  context 'Valid' do
    it 'should create a valid notification device id' do
      expect(build(:event)).to be_valid
    end
  end

  describe '#create' do
    it 'should not let you create a duplicate device id' do
      ndi = create(:notification_device_id)
      ndi2 = build(:notification_device_id, device_identifier: ndi.device_identifier)
      expect(ndi2).not_to be_valid
      expect(ndi2.errors[:device_identifier]).not_to be_empty
    end
    it 'should let you create a notification device id without a person' do
      ndi = build(:notification_device_id, person_id: nil)
      expect(ndi).not_to be_valid
      expect(ndi.errors[:person]).not_to be_empty
    end
    it 'should let you create a notification device id without a device identifier' do
      ndi = build(:notification_device_id, device_identifier: nil)
      expect(ndi).not_to be_valid
      expect(ndi.errors[:device_identifier]).not_to be_empty
    end
  end
end
