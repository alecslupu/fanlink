# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V4::Trivia::PictureAvailableAnswersController, type: :controller do
  # TODO: auto-generated
  describe "GET show" do
    it "returns the picture answers with the attached image" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        picture_answer = create(
          :trivia_picture_available_answer,
          picture: fixture_file_upload('images/better.png', 'image/png')
        )

        get :show, params: { id: picture_answer.id }
        expect(response).to be_successful
        expect(json['url']).not_to eq(nil)
      end
    end
  end
end
