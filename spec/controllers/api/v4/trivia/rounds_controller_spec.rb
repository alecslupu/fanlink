require "rails_helper"

RSpec.describe Api::V4::Trivia::RoundsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    pending
  end

  describe "POST change_status" do
    let(:person) { create(:person) }
    let(:game) { ActsAsTenant.with_tenant(person.product) { create(:trivia_game, with_leaderboard: false) } }
    let(:round) { ActsAsTenant.with_tenant(person.product) { create(:future_trivia_round, with_leaderboard: false, game: game) } }
    it "can be called being unauthorized" do
      ActsAsTenant.with_tenant(person.product) do
        post :change_status, params: { game_id: game.id, round_id: round.id, product: person.product.internal_name}
        expect(response.status).to eq(401)
      end
    end
    it "should have some kind of authorization" do
      ActsAsTenant.with_tenant(person.product) do
        post :change_status, params: { game_id: game.id, round_id: round.id, product: person.product.internal_name, token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRob3JpemF0aW9uIjoiRVJjRVQzenAifQ.XvEudHy8vLVuZc5MlPfo8NmeSTSmhuynxXQT7PE2rBM",
                                       status: :locked
        }
        expect(response.body).to eq("")
        expect(response.status).to eq(200)
      end
    end
    it "should have some kind of authorization" do
      ActsAsTenant.with_tenant(person.product) do
        post :change_status, params: { game_id: game.id, round_id: round.id,
                                       product: person.product.internal_name, token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRob3JpemF0aW9uIjoiRVJjRVQzenAifQ.XvEudHy8vLVuZc5MlPfo8NmeSTSmhuynxXQT7PE2rBM",
                                       status: :locked
        }

        expect(round.reload.status).to eq("locked")
        expect(response.status).to eq(200)
      end
    end
  end
end
