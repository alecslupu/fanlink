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
        get :index, params: {page: 1, per_page: 2}
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
        get :index, params: {page: 2, per_page: 2}
        expect(response).to be_successful
        posts = json["recommended_posts"].map { |p| p["id"].to_i }
        expect(posts.size).to eq(2)
        expect(posts.sort).to eq([post_list[2].id, post_list[3].id].sort)
      end
    end
  end
end
