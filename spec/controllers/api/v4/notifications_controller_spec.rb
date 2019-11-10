require 'rails_helper'

RSpec.describe Api::V4::NotificationsController, type: :controller do
  describe '#create' do
    it 'creates a new notification for a user with pin message from' do
      person = create(:person, pin_messages_from: true)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = 'body'

        post :create, params: { notification: { body: body } }

        expect(response).to be_successful
        notification = Notification.last
        expect(notification.body).to eq(body)
        expect(notification.person_id). to eq(person.id)
      end
    end

    it 'creates a new notification for a user with product account' do
      person = create(:person, product_account: true)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = 'body'

        post :create, params: { notification: { body: body } }

        expect(response).to be_successful
        notification = Notification.last
        expect(notification.body).to eq(body)
        expect(notification.person_id). to eq(person.id)
      end
    end

    it 'does not accept a user without product account or pin message from' do
      person = create(:person, product_account: false, pin_messages_from: false)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = 'body'

        post :create, params: { notification: { body: body } }

        expect(response).to be_unauthorized
      end
    end
    it 'does not accept a user without product account or pin message from' do
      person = create(:person, product_account: false, pin_messages_from: false)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = 'body'

        post :create, params: { notification: { body: body } }

        expect(response).to be_unauthorized
      end
    end

    it 'creates a delayed job for when a notification is created' do
      person = create(:person, pin_messages_from: true)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expect{
          post :create, params: { notification: { body: 'body' } }
        }.to change(Notification, :count).by(1)
      end
    end
  end
end
