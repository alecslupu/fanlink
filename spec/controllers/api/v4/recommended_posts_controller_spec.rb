# frozen_string_literal: true

require "spec_helper"

RSpec.describe Api::V4::RecommendedPostsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    it "should get all recommended posts when not providing page param" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:recommended_post, 26, status: :published) #default per_page number is 25
        draft = create(:post)
        published_post = create(:published_post)
        login_as(person)
        get :index
        expect(response).to be_successful
        posts = json["recommended_posts"].map { |p| p["id"].to_i }
        expect(posts.size).to eq(26)
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

    it "return the recommended posts with polls if active" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        # post_list = create_list(:recommended_post, 8, status: :published).reverse
        post = create(:recommended_post, status: :published)
        post.poll = create(:poll)
        login_as(person)
        get :index
        expect(response).to be_successful
        poll = post.poll
        recommended_post = json["recommended_posts"].first
        expect(recommended_post["poll"]["id"].to_i).to eq(poll.id)
        expect(recommended_post["poll"]["description"]).to eq(poll.description)
        expect(recommended_post["poll"]["duration"]).to eq(poll.duration)
      end
    end

    it "return the recommended posts with polls if active and param page is given" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        # post_list = create_list(:recommended_post, 8, status: :published).reverse
        post = create(:recommended_post, status: :published)
        post.poll = create(:poll)
        login_as(person)
        get :index, params: { page: 1 }
        expect(response).to be_successful
        poll = post.poll
        recommended_post = json["recommended_posts"].first
        expect(recommended_post["poll"]["id"].to_i).to eq(poll.id)
        expect(recommended_post["poll"]["description"]).to eq(poll.description)
        expect(recommended_post["poll"]["duration"]).to eq(poll.duration)
      end
    end
  end
end
