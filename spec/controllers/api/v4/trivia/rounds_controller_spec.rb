# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V4::Trivia::RoundsController, type: :controller do
  # TODO: auto-generated
  describe 'GET index' do
    pending
  end

  describe 'POST change_status' do
    let(:token) {
      %w(
        eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9
        eyJhdXRob3JpemF0aW9uIjoiRVJjRVQzenAifQ
        XvEudHy8vLVuZc5MlPfo8NmeSTSmhuynxXQT7PE2rBM
      ).join(".")
    }
    it 'can be called being unauthorized' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        game = create(:trivia_game, with_leaderboard: false)
        round = create(:trivia_round, with_leaderboard: false, status: :published, game: game)

        post :change_status, params: { game_id: game.id, round_id: round.id, product: person.product.internal_name }
        expect(response.status).to eq(401)
      end
    end
    it 'should have some kind of authorization' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        game = create(:trivia_game, with_leaderboard: false)
        round = create(:trivia_round, with_leaderboard: false, status: :published, game: game)

        post :change_status, params: {
          game_id: game.id,
          round_id: round.id,
          product: person.product.internal_name,
          token: token,
          status: :locked
        }
        expect(response.body).to eq('')
        expect(response.status).to eq(200)
      end
    end
    it 'should have some kind of authorization' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        game = create(:trivia_game, with_leaderboard: false)
        round = create(:trivia_round, with_leaderboard: false, status: :published, game: game)

        post :change_status, params: { game_id: game.id,
                                       round_id: round.id,
                                       product: person.product.internal_name,
                                       token: token,
                                       status: :locked }

        expect(round.reload.status).to eq('locked')
        expect(response.status).to eq(200)
      end
    end
  end
end
