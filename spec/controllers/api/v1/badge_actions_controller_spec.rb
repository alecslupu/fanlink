# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V1::BadgeActionsController, type: :controller do
  describe '#create' do
    it 'should create a new action and return partially earned badge with highest percent earned' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        action_type = create(:action_type)
        badge1 = create(:badge, action_type: action_type, action_requirement: 3)
        badge2 = create(:badge, action_type: action_type, action_requirement: 4)
        badge_other = create(:badge)
        post :create, params: { badge_action: { action_type: action_type.internal_name } }
        expect(response).to have_http_status(200)
        expect(pending_badge_json(json['pending_badge'], badge1)).to be_truthy
      end
    end
    it 'should not include badge before issued_from time as partially earned badge with highest percent earned' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        action_type = create(:action_type)
        badge1 = create(:badge, action_type: action_type, action_requirement: 3)
        create(:badge, action_type: action_type, action_requirement: 2, issued_from: Time.zone.now + 1.day)
        post :create, params: { badge_action: { action_type: action_type.internal_name } }
        expect(response).to have_http_status(200)
        expect(pending_badge_json(json['pending_badge'], badge1)).to be_truthy
      end
    end
    it 'should create a new action and return single earned badge' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        action_type = create(:action_type)
        badge1 = create(:badge, action_type: action_type, action_requirement: 1)
        badge2 = create(:badge, action_type: action_type, action_requirement: 4)
        badge_other = create(:badge)
        post :create, params: { badge_action: { action_type: action_type.internal_name } }
        expect(response).to have_http_status(200)
        expect(json['badges_awarded'].count).to eq(1)
        expect(badge_json(json['badges_awarded'].first)).to be_truthy
      end
    end
    it 'should create a new action and return multiple earned badges' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        action_type = create(:action_type)
        badge1 = create(:badge, action_type: action_type, action_requirement: 1)
        badge2 = create(:badge, action_type: action_type, action_requirement: 1)
        badge_other = create(:badge)
        post :create, params: { badge_action: { action_type: action_type.internal_name } }
        expect(response).to have_http_status(200)
        expect(json['badges_awarded'].count).to eq(2)
        expect(badge_json(json['badges_awarded'].first)).to be_truthy
        expect(badge_json(json['badges_awarded'].last)).to be_truthy
      end
    end
    it 'should create a new action and return nil if everything already earned' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        action_type = create(:action_type)
        badge1 = create(:badge, action_type: action_type, action_requirement: 1)
        BadgeAward.create(person: person, badge: badge1)
        post :create, params: { badge_action: { action_type: action_type.internal_name } }
        expect(response).to have_http_status(200)
        expect(json.keys).to include('pending_badge')
        expect(json['pending_badge']).to be_nil
      end
    end
    it 'should not create an action if not enough time has passed since last one of this type' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        action_type = create(:action_type, seconds_lag: 120)
        person.badge_actions.create(action_type: action_type)
        login_as(person)
        post :create, params: { badge_action: { action_type: action_type.internal_name } }
        expect(response).to have_http_status(429)
      end
    end
    it 'should create an action if enough time has passed since last one of this type' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        action_type = create(:action_type, seconds_lag: 120)
        person.badge_actions.create(action_type: action_type)
        Timecop.travel(Time.zone.now + 121.seconds) do
          login_as(person)
          post :create, params: { badge_action: { action_type: action_type.internal_name } }
          expect(response).to have_http_status(200)
        end
      end
    end
    it 'should not create an action with dup person, action and identifier' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        action_type = create(:action_type)
        ident = 'myident'
        person.badge_actions.create(action_type: action_type, identifier: ident)
        login_as(person)
        post :create, params: { badge_action: { action_type: action_type.internal_name, identifier: ident } }
        expect(response).to have_http_status(422)

        expect(json['errors'].first).to include(_('Sorry, you cannot get credit for that action again.'))
      end
    end
    it 'should not create action if missing badge action' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post :create, params: {}
        expect(response).to have_http_status(422)
        expect(json['errors']).to include(_('You must supply a badge action type.'))
      end
    end
    it 'should not create action if missing action type' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post :create, params: { badge_action: { identifier: 'fdafdf' } }
        expect(response).to have_http_status(422)
        expect(json['errors']).to include(_('You must supply a badge action type.'))
      end
    end
  end
end
