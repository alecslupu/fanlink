require "rails_helper"

RSpec.describe Api::V4::Trivia::SubscriptionsController, type: :controller do
  describe "GET destroy" do
    it "destroys the subscription" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        subscriber = create(:trivia_subscriber, person: person)
        login_as(person)

        expect(Trivia::Subscriber.count).to eq(1)
        delete :destroy, params: { game_id: subscriber.trivia_game_id }
        expect(Trivia::Subscriber.count).to eq(0)
      end
    end
  end

  describe "GET show" do
    it "displays the resource" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        subscriber = create(:trivia_subscriber, person: person)
        login_as(person)

        expect(Trivia::Subscriber.count).to eq(1)
        get :show, params: { game_id: subscriber.trivia_game_id }
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#create" do
    it "enroll an user in a trivia Game" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        game = create(:trivia_game)
        login_as(person)

        expect(Trivia::Subscriber.count).to eq(0)
        post :create, params: { game_id: game.id, subscribed: false }

        # expect(response.status).to eq(200)
        expect(Trivia::Subscriber.count).to eq(1)
      end
    end
  end

  describe "PUT update" do
    it "displays the resource" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        subscriber = create(:trivia_subscriber, person: person, subscribed: false)
        login_as(person)

        expect(Trivia::Subscriber.last.subscribed).to be_falsey
        post :update, params: { game_id: subscriber.trivia_game_id, subscribed: true }
        expect(Trivia::Subscriber.last.subscribed).to be_truthy
        expect(response.status).to eq(204)
      end
    end
  end
end
