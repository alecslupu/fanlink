# frozen_string_literal: true

require "spec_helper"

RSpec.describe Api::V4::QuestActivitiesController, type: :controller do
  describe "GET show" do
    it 'returns the quest_activity with the attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        quest_activity = create(:quest_activity, picture: fixture_file_upload('images/better.png', 'image/png'))
        get :show, params: { id: quest_activity.id }

        expect(response).to be_successful
        expect(json['activity']['picture_url']).not_to eq(nil)
      end
    end
  end

  describe "PUT update" do
    it "updates a quest_activity's attachment" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        quest_activity = create(:quest_activity)

        put :update, params: {
          id: quest_activity.id,
          quest_activity: {
            picture: fixture_file_upload('images/better.png', 'image/png')
          }
        }

        expect(response).to be_successful
        expect(QuestActivity.last.picture.exists?).to be_truthy
        expect(json['activity']['picture_url']).to include('better.png')
      end
    end
  end
end
