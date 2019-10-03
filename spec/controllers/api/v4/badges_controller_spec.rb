require "rails_helper"

RSpec.describe Api::V4::BadgesController, type: :controller do
  describe 'POST create' do
    it 'creates a badge' do
      user = create(:person, role: :admin)
      ActsAsTenant.with_tenant(user.product) do
        login_as(user)
        name = 'A name'
        internal_name = 'internal'
        description = 'description'
        action_type = create(:action_type)
        post :create, params: {
          badge: {
            name: name,
            internal_name: internal_name,
            description: description,
            action_type_id: action_type.id
          }
        }
        expect(response).to be_successful
        badge = Badge.last
        expect(badge.name).to eq(name)
        expect(badge.internal_name).to eq(internal_name)
        expect(badge.action_type_id).to eq(action_type.id)
      end
    end
  end
end
