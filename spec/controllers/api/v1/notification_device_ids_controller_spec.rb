# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V1::NotificationDeviceIdsController, type: :controller do
  describe '#create' do
    it 'should insert a new device id' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post :create, params: { device_id: 'dfadfa' }
        expect(response).to have_http_status(200)
        expect(person.notification_device_ids.where(device_identifier: 'dfadfa').exists?).to be_truthy
      end
    end
    it 'should not insert a device id if missing identifier' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post :create, params: {}
        expect(response).to have_http_status(422)
        expect(json['errors']).to include('Missing device_id')
      end
    end
    it 'should not insert a new device id if not logged in' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        did = 'fkafkaf'
        post :create, params: { device_id: did }
        expect(response).to have_http_status(401)
        expect(person.notification_device_ids.where(device_identifier: did).exists?).to be_falsey
      end
    end
    it 'should not insert a duplicate device id' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        did = 'fkafkaf'
        create(:notification_device_id, person: person, device_identifier: did)
        login_as(person)
        post :create, params: { device_id: did }
        expect(response).to have_http_status(422)
        expect(json['errors'].first).to include('already registered')
      end
    end
  end

  describe '#destroy' do
    it 'should destroy a device id' do
      ndi = create(:notification_device_id)
      ActsAsTenant.with_tenant(ndi.person.product) do
        login_as(ndi.person)
        post :destroy, params: { device_id: ndi.device_identifier }
        expect(response).to have_http_status(200)
        expect(ndi).not_to exist_in_database
      end
    end
    it 'should 404 if not owner' do
      ndi = create(:notification_device_id)
      ActsAsTenant.with_tenant(ndi.person.product) do
        login_as(create(:person))
        post :destroy, params: { device_id: ndi.device_identifier }
        expect(response).to have_http_status(404)
        expect(ndi).to exist_in_database
      end
    end
    it 'should 404 if not an id we have' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post :destroy, params: { device_id: 'dfafewrddddddfwefref' }
        expect(response).to have_http_status(404)
      end
    end
    it 'should not delete if not logged in' do
      ndi = create(:notification_device_id)
      ActsAsTenant.with_tenant(ndi.person.product) do
        post :destroy, params: { device_id: ndi.device_identifier }
        expect(response).to have_http_status(401)
      end
    end
    it 'should just return unauthorized even if bad id' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post :destroy, params: { device_id: 'dfadeieecfdads;fa2' }
        expect(response).to have_http_status(401)
      end
    end
  end
end
