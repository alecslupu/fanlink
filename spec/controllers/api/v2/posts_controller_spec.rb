# frozen_string_literal: true

require "spec_helper"

RSpec.describe Api::V2::PostsController, type: :controller do
  describe "#index" do
    pending
  end

  describe "#create" do
    it "creates a post with attachments when it's valid" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        post :create, params: {
          post: {
            body: "Body",
            picture: fixture_file_upload('images/better.png', 'image/png'),
            audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4')
          }
        }

        expect(response).to have_http_status(200)
        expect(Post.last.picture.attached?).to be_truthy
        expect(Post.last.audio.attached?).to be_truthy
        expect(json['post']['picture_url']).not_to be_nil
        expect(json['post']['audio_url']).not_to be_nil
      end
    end
  end
end
