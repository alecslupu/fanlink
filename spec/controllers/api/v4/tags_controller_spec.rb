# frozen_string_literal: true
require "spec_helper"

RSpec.describe Api::V4::TagsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    it"returns posts with reactions info" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person2 = create(:person)
        tag = create(:tag)
        post = create(:published_post, person: person2)
        1.upto 4 do
          create(:post_reaction, post: post)
        end
        post.tags << tag

        create(:post_reaction, person: person, post: post)

        person.follow(person2)
        person2.follow(person)

        get :index, params: { tag_name: tag.name }

        expect(response).to be_successful
        post = json["posts"].first

        expect(post["post_reaction"]).not_to eq(nil)
        expect(post["post_reaction_counts"]).not_to eq(nil)
      end
    end
  end
end
