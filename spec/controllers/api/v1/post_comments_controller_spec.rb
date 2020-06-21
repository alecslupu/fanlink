# frozen_string_literal: true

require "spec_helper"

RSpec.describe Api::V1::PostCommentsController, type: :controller do
  describe "#create" do
    it "should create a post comment" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        po = create(:post, status: :published)
        expect {
          post :create, params: { post_id: po.id, post_comment: { body: "a comment" } }
        }.to change { po.comments.count }.by(1)
        expect(response).to be_successful
        expect(post_comment_json(json["post_comment"])).to be true
      end
    end
    # it "should create a post comment with one mention" do
    #   person = create(:person)
    #   ActsAsTenant.with_tenant(person.product) do
    #     followee2 = create(:person)
    #     person.follow(followee2)
    #     login_as(person)
    #     po = create(:post, status: :published)
    #     expect {
    #       post :create, params: {post_id: po.id, post_comment: {
    #         body: "a comment", mentions: [
    #           {
    #             person_id: followee2.id, location: 1, length: 2,
    #           },
    #         ],
    #       },}
    #     }.to change { po.comments.count }.by(1)
    #     expect(response).to be_successful
    #     comment = po.comments.last
    #     expect(comment.mentions.count).to eq(1)
    #     expect(post_comment_json(json["post_comment"])).to be true
    #   end
    # end
    # it "should create a post comment with multiple mentions" do
    #   person = create(:person)
    #   ActsAsTenant.with_tenant(person.product) do
    #     followee1 = create(:person)
    #     followee2 = create(:person)
    #     person.follow(followee1)
    #     person.follow(followee2)
    #     login_as(person)
    #     po = create(:post, status: :published)

    #     expect {
    #       post :create, params: {post_id: po.id, post_comment: {body: "a comment", mentions: [
    #         {person_id: followee2.id, location: 1, length: 2},
    #         {person_id: followee1.id, location: 11, length: 3},
    #       ],},}
    #     }.to change { po.comments.count }.by(1)
    #     expect(response).to be_successful
    #     comment = po.comments.last
    #     expect(comment.mentions.count).to eq(2)
    #     expect(post_comment_json(json["post_comment"])).to be true
    #   end
    # end

    it "should not create a post comment if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(create(:product)) do
        po = create(:post, status: :published)
        expect {
          post :create, params: { post_id: po.id, post_comment: { body: "a comment" } }
        }.to change { po.comments.count }.by(0)
        expect(response).to be_unauthorized
      end
    end

    it "should not create a post comment if logged in to a different product" do
      person = create(:person)
      ActsAsTenant.with_tenant(create(:product)) do
        po = create(:post, status: :published)
        login_as(person)
        expect {
          post :create, params: { post_id: po.id, post_comment: { body: "a comment" } }
        }.to change { po.comments.count }.by(0)
        expect(response).to be_not_found
      end
    end
  end

  describe "#destroy" do
    it "should delete a comment by an admin" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        comment = create(:post_comment, person: person, body: "bleeb blub")
        admin_user = create(:admin_user)
        login_as(admin_user)
        expect(comment).to exist_in_database
        delete :destroy, params: { post_id: comment.post_id, id: comment.id }
        expect(response).to be_successful
        expect(comment).not_to exist_in_database
      end
    end
    it "should delete a comment by creator" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        comment = create(:post_comment, person: person, body: "bleeb blub")
        expect(comment).to exist_in_database
        login_as(person)
        delete :destroy, params: { post_id: comment.post_id, id: comment.id }
        expect(response).to be_successful
        expect(comment).not_to exist_in_database
      end
    end
    it "should not delete a comment by other than creator or admin" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        creator = create(:person)
        comment = create(:post_comment, person: creator, body: "bleeb blub")
        expect(comment).to exist_in_database
        login_as(create(:person))
        delete :destroy, params: { post_id: comment.post_id, id: comment.id }
        expect(response).to be_not_found
        expect(comment).to exist_in_database
      end
    end
    it "should not delete a comment from another product by admin" do
      person = create(:person)
      admin_user = create(:admin_user, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        comment = create(:post_comment, person: person, body: "bleeb blub")
        expect(comment).to exist_in_database
        login_as(admin_user)
        delete :destroy, params: { post_id: comment.post_id, id: comment.id }
        expect(response).to be_not_found
        expect(comment).to exist_in_database
      end
    end
    it "should not delete a comment if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        creator = create(:person)
        comment = create(:post_comment, person: creator, body: "bleeb blub")
        expect(comment).to exist_in_database
        delete :destroy, params: { post_id: comment.post_id, id: comment.id }
        expect(response).to be_unauthorized
        expect(comment).to exist_in_database
      end
    end
  end

  describe "#index" do
    it "should get the first page of the comments for a post" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        followee1 = create(:person)
        person.follow(followee1)
        po = create(:post, person_id: followee1.id, body: "a post")
        po.comments.create(body: "a comment", person: person)
        po.comments.create(body: "another comment", person: person)
        po.comments.create(body: "a comment", person: person)
        po.comments.create(body: "another comment", person: person)
        po.comments.create(body: "another comment", person: person, hidden: true)

        pp = 2
        get :index, params: { post_id: po.id, page: 1, per_page: pp }
        expect(response).to be_successful
        expect(json["post_comments"].count).to eq(pp)
        # expect(json["post_comments"].first).to eq(post_comment_json(@post.comments.visible.order(created_at: :desc).first))
        expect(post_comment_json(json["post_comments"].first)).to be true
      end
    end
    it "should get all the comments for a post without comments" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        followee2 = create(:person)
        person.follow(followee2)
        po = create(:post, person: followee2)
        get :index, params: { post_id: po.id }
        expect(response).to be_successful
        expect(json["post_comments"].count).to eq(0)
      end
    end
  end

  describe "#list" do
    it "should get the paginated list of all comments unfiltered" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        login_as(admin)
        5.times { |n| create(:post_comment, body: "some body that I made up #{n}") }

        get :list, params: { per_page: 2, page: 1 }
        expect(response).to be_successful
        pc_json = json["post_comments"]
        expect(pc_json.count).to eq(2)
        # expect(pc_json.first).to eq(post_comment_list_json(@list_comments.last))
        expect(post_comment_list_json(pc_json.first)).to be true
      end
    end
    it "should get list of comments paginated at page 2" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        login_as(admin)
        5.times { |n| create(:post_comment, body: "some body that I made up #{n}") }

        get :list, params: { per_page: 2, page: 2 }
        expect(response).to be_successful
        pc_json = json["post_comments"]
        expect(pc_json.count).to eq(2)
        # expect(pc_json.first).to eq(post_comment_list_json(@list_comments[-3]))
        expect(post_comment_list_json(pc_json.first)).to be true
      end
    end
    it "should get the list of all post comments filtered on body" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        login_as(admin)
        5.times { |n| create(:post_comment, body: "some body that I made up #{n}") }
        fragment = "made up 2"
        get :list, params: { body_filter: fragment }
        expect(response).to be_successful
        pc_json = json["post_comments"]
        expect(pc_json.count).to eq(1)
        expect(pc_json.first["body"]).to include(fragment)
      end
    end
    it "should get the list of all post comments filtered on full person username match" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        people_list = [create(:person, username: "cuser111", email: "cuser1112@example.com"),
                       create(:person, username: "cuser112", email: "cuser112@example.com"),
                       create(:person, username: "cuser121", email: "cuser121@example.com"),]
        login_as(admin)
        person = people_list.sample
        get :list, params: { person_filter: person.username }
        expect(response).to be_successful
        post_comments = PostComment.where(person_id: person.id)
        pc_json = json["post_comments"]
        expect(pc_json.count).to eq(post_comments.count)
        expect(pc_json.map { |jp| jp["id"] }.sort).to eq(post_comments.map { |p| p.id.to_s }.sort)
      end
    end
    it "should get the list of all post comments filtered on partial person username match" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        people_list = [create(:person, username: "cuser111", email: "cuser1112@example.com"),
                       create(:person, username: "cuser112", email: "cuser112@example.com"),
                       create(:person, username: "cuser121", email: "cuser121@example.com"),]
        login_as(admin)
        people = [people_list.first, people_list[1]]
        get :list, params: { person_filter: "cuser11" }
        expect(response).to be_successful
        post_comments = PostComment.where(person_id: people)
        pc_json = json["post_comments"]
        expect(pc_json.count).to eq(post_comments.count)
        expect(pc_json.map { |jp| jp["id"] }.sort).to eq(post_comments.map { |p| p.id.to_s }.sort)
      end
    end
    it "should get the list of all post comments filtered on full person email match" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        people_list = [create(:person, username: "cuser111", email: "cuser1112@example.com"),
                       create(:person, username: "cuser112", email: "cuser112@example.com"),
                       create(:person, username: "cuser121", email: "cuser121@example.com"),]
        login_as(admin)
        person = people_list.sample
        get :list, params: { person_filter: person.email }
        expect(response).to be_successful
        post_comments = PostComment.where(person_id: person.id)
        pc_json = json["post_comments"]
        expect(pc_json.count).to eq(post_comments.count)
        expect(pc_json.map { |jp| jp["id"] }.sort).to eq(post_comments.map { |p| p.id.to_s }.sort)
      end
    end
    it "should get the list of all post comments filtered on partial person email match" do
      admin = create(:admin_user)
      ActsAsTenant.with_tenant(admin.product) do
        people_list = [create(:person, username: "cuser111", email: "cuser1112@example.com"),
                       create(:person, username: "cuser112", email: "cuser112@example.com"),
                       create(:person, username: "cuser121", email: "cuser121@example.com"),]
        login_as(admin)
        people = [people_list.first, people_list[1]]
        get :list, params: { person_filter: "112@example" }
        expect(response).to be_successful
        post_comments = PostComment.where(person_id: people)
        pc_json = json["post_comments"]
        expect(pc_json.count).to eq(post_comments.count)
        expect(pc_json.map { |jp| jp["id"] }.sort).to eq(post_comments.map { |p| p.id.to_s }.sort)
      end
    end
  end
end
