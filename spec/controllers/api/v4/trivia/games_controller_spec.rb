# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V4::Trivia::GamesController, type: :controller do
  # TODO: auto-generated
  describe 'GET index' do
    it 'returns all the upcomming games with their attached images' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        allow(Trivia::Game).to receive(:upcomming).and_return build_list(
                                                                :trivia_game,
                                                                3,
                                                                status: :published,
                                                                picture: fixture_file_upload('images/better.png', 'image/png')
                                                              )

        get :index
        expect(response).to be_successful
        expect(json['games'].size).to eq(3)
        json['games'].each do |game|
          expect(game['picture']).not_to eq(nil)
        end
      end
    end
  end
  # TODO: auto-generated
  describe 'GET completed' do
    it 'returns all the completed games with their attached images' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        allow(Trivia::Game).to receive(:completed).and_return build_list(
                                                                :trivia_game,
                                                                3,
                                                                status: :closed,
                                                                end_date: (DateTime.now - 1.day).to_i,
                                                                picture: fixture_file_upload('images/better.png', 'image/png')
                                                              )

        get :completed
        expect(response).to be_successful
        expect(json['games'].size).to eq(3)
        json['games'].each do |game|
          expect(game['picture']).not_to eq(nil)
        end
      end
    end
  end
end
