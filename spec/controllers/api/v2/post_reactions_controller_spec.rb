require "spec_helper"

RSpec.describe Api::V2::PostReactionsController, type: :controller do
  before(:all) do
    @reaction = "1F600"
  end

  describe "#create" do
    it "should create a new reaction" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        p = create(:post)
        expect {
          post :create, params: { post_id: p.id, post_reaction: { reaction: @reaction } }
        }.to change { p.reactions.count }.by(1)
        expect(response).to be_successful
        # reaction = PostReaction.last
        expect(post_reaction_json(json["post_reaction"])).to be true
      end
    end
    it "should not create a reaction if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        p = create(:post)
        expect {
          post :create, params: { post_id: p.id, post_reaction: { reaction: @reaction } }
        }.to change { PostReport.count }.by(0)
        expect(response).to be_unauthorized
      end
    end
    it "should not create a reaction for a post from a different product" do
      person = create(:person, product: create(:product))
      p = create(:post, person: person)
      person = create(:person, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expect {
          post :create, params: { post_id: p.id, post_reaction: { reaction: @reaction } }
        }.to change { PostReaction.count }.by(0)
        expect(response).to be_not_found
      end
    end
    it "should require valid emoji sequence" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        p = create(:post)
        nonemoji = "11FFFF"
        expect {
          post :create, params: { post_id: p.id, post_reaction: { reaction: nonemoji } }
        }.to change { PostReaction.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Reaction is not a valid value.")
      end
    end
  end

  describe "#destroy" do
    it "should delete a reaction" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        reaction = create(:post_reaction, person: person)
        login_as(person)
        expect {
          delete :destroy, params: { post_id: reaction.post_id, id: reaction.id }
        }.to change { PostReaction.count }.by(-1)
        expect(response).to be_successful
        expect(reaction).not_to exist_in_database
      end
    end
    it "should not delete a reaction if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        reaction = create(:post_reaction)
        expect {
          delete :destroy, params: { post_id: reaction.post_id, id: reaction.id }
        }.to change { PostReaction.count }.by(0)
        expect(response).to be_unauthorized
        expect(reaction).to exist_in_database
      end
    end
    it "should not delete a reaction of someone else" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        reaction = create(:post_reaction)
        login_as(person)
        expect {
          delete :destroy, params: { post_id: reaction.post_id, id: reaction.id }
        }.to change { PostReaction.count }.by(0)
        expect(response).to be_not_found
        expect(reaction).to exist_in_database
      end
    end
  end

  describe "#update" do
    it "should change the reaction to a post" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        reaction = create(:post_reaction, person: person, reaction: "1F601")
        login_as(person)
        patch :update, params: { id: reaction.id, post_id: reaction.post_id, post_reaction: { reaction: @reaction } }
        expect(response).to be_successful
        expect(reaction.reload.reaction).to eq(@reaction)
        # expect(json["post_reaction"]).to eq(post_reaction_json(reaction))
        expect(post_reaction_json(json["post_reaction"])).to be true
      end
    end
    it "should not change the reaction to a post if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        reaction = create(:post_reaction, person: person, reaction: @reaction)
        patch :update, params: { id: reaction.id, post_id: reaction.post_id, post_reaction: { reaction: "1F601" } }
        expect(response).to be_unauthorized
        expect(reaction.reload.reaction).to eq(@reaction)
      end
    end
    it "should not change the reaction of someone else" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        reaction = create(:post_reaction, reaction: @reaction)
        patch :update, params: { id: reaction.id, post_id: reaction.post_id, post_reaction: { reaction: "1F601" } }
        expect(response).to be_not_found
        expect(reaction.reload.reaction).to eq(@reaction)
      end
    end
  end
end
