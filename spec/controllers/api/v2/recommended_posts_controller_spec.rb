# frozen_string_literal: true
require "spec_helper"

RSpec.describe Api::V2::RecommendedPostsController, type: :controller do
  describe "#index" do
    it "should get all recommended posts" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:recommended_post, 8, status: :published)
        draft = create(:post)
        published_post = create(:published_post)
        login_as(person)
        get :index
        expect(response).to be_successful
        posts = json["recommended_posts"].map { |p| p["id"].to_i }
        expect(posts.size).to eq(8)
        expect(posts).not_to include(published_post.id)
        expect(posts).not_to include(draft.id)
      end
    end
    it "should get page 1 of recommended posts" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post_list = create_list(:recommended_post, 8, status: :published).reverse
        login_as(person)
        get :index, params: { page: 1, per_page: 2 }
        expect(response).to be_successful
        posts = json["recommended_posts"].map { |p| p["id"].to_i }
        expect(posts.size).to eq(2)
        expect(posts.sort).to eq([post_list[0].id, post_list[1].id].sort)
      end
    end
    it "should get page 2 of recommended posts" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post_list = create_list(:recommended_post, 8, status: :published).reverse
        login_as(person)
        get :index, params: { page: 2, per_page: 2 }
        expect(response).to be_successful
        posts = json["recommended_posts"].map { |p| p["id"].to_i }
        expect(posts.size).to eq(2)
        expect(posts.sort).to eq([post_list[2].id, post_list[3].id].sort)
      end
    end
    it "should return unauthorized if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:recommended_post, 8, status: :published)
        get :index, params: { page: 1, per_page: 25 }
        expect(response).to be_unauthorized
      end
    end
  end
end
