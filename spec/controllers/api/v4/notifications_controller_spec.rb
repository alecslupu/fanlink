require 'rails_helper'

RSpec.describe Api::V4::NotificationsController, type: :controller do
  describe '#create' do
    it 'creates a new notification for a user with pin message from' do
      person = create(:person, pin_messages_from: true)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        post :create, params: { notification: { body: 'body' } }

        expect(response).to be_successful
      end
    end
  end
end
