# frozen_string_literal: true

require "spec_helper"

RSpec.describe Api::V2::BlocksController, type: :controller do
  describe "#create" do
    it "should block person" do
      blocker = create(:person)
      ActsAsTenant.with_tenant(blocker.product) do
        to_be_blocked = create(:person)
        login_as(blocker)
        post :create, params: { block: { blocked_id: to_be_blocked.id } }
        expect(blocker.blocked?(to_be_blocked)).to be_truthy
        expect(response).to have_http_status(200)
        expect(block_json(json["block"])).to be_truthy
      end
    end
    it "should kill relationships with person" do
      blocker = create(:person)
      ActsAsTenant.with_tenant(blocker.product) do
        to_be_blocked = create(:person)
        rel1 = create(:relationship, requested_by: blocker, requested_to: to_be_blocked)
        login_as(blocker)
        post :create, params: { block: { blocked_id: to_be_blocked.id } }
        expect(response).to have_http_status(200)
        expect(rel1).not_to exist_in_database
      end
    end
    it "should unfollow person" do
      blocker = create(:person)
      ActsAsTenant.with_tenant(blocker.product) do
        to_be_blocked = create(:person)
        blocker.follow(to_be_blocked)
        login_as(blocker)
        post :create, params: { block: { blocked_id: to_be_blocked.id } }
        expect(response).to have_http_status(200)
        expect(blocker.following?(to_be_blocked)).to be_falsey
      end
    end
    it "should be unfollowed blocked person" do
      blocker = create(:person)
      ActsAsTenant.with_tenant(blocker.product) do
        to_be_blocked = create(:person)
        to_be_blocked.follow(blocker)
        login_as(blocker)
        post :create, params: { block: { blocked_id: to_be_blocked.id } }
        expect(response).to be_successful
        expect(to_be_blocked.following?(blocker)).to be_falsey
      end
    end
    it "should not block person already blocked" do
      blocker = create(:person)
      ActsAsTenant.with_tenant(blocker.product) do
        to_be_blocked = create(:person)
        blocker.block(to_be_blocked)
        login_as(blocker)
        post :create, params: { block: { blocked_id: to_be_blocked.id } }
        expect(response).to have_http_status(422)
        expect(json["errors"].first).to include(_("That user is already blocked."))
      end
    end
  end
  describe "#destroy" do
    it "should unblock person" do
      blocker = create(:person)
      ActsAsTenant.with_tenant(blocker.product) do
        to_be_unblocked = create(:person)
        block = blocker.block(to_be_unblocked)
        login_as(blocker)
        post :destroy, params: { id: block.id }
        expect(response).to have_http_status(200)
        expect(block).not_to exist_in_database
      end
    end
    it "should not unblock if blocker not current user" do
      blocker = create(:person)
      ActsAsTenant.with_tenant(blocker.product) do
        not_to_be_unblocked = create(:person)
        block = blocker.block(not_to_be_unblocked)
        login_as(create(:person))
        post :destroy, params: { id: block.id }
        expect(response).to have_http_status(404)
        expect(block).to exist_in_database
      end
    end
  end
end
