# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V4::BadgeActionsController, type: :controller do

  describe 'POST create' do
    it 'return an error when the are no rewards on the badges' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        action_type = create(:action_type)
        badge2 = create(:badge, action_type: action_type, action_requirement: 4)
        badge2.reward.destroy
        post :create, params: { badge_action: { action_type: action_type.internal_name } }

        expect(response).to be_not_found
        expect(json['errors']['base']).to include(_('Reward does not exist for that action type.'))
      end
    end

    it 'the awarded badge' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        action_type = create(:action_type)
        badge = create(:badge, action_type: action_type)
        badge2 = create(:badge, action_type: action_type)
        reward = badge.reward
        reward2 = badge2.reward

        post :create, params: { badge_action: { action_type: action_type.internal_name, identifier: 345 } }
        expect(json["badges_awarded"]). to be_truthy
      end
    end
  end
end
