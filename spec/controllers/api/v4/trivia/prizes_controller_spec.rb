require "rails_helper"

RSpec.describe Api::V4::Trivia::PrizesController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    it 'returns all merchandises with their attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        trivia_game = create(:trivia_game)
        create_list(:trivia_prize,
          3,
          game: trivia_game,
          status: :published,
          photo: fixture_file_upload('images/better.png', 'image/png')
        )

        get :index, params: { game_id: trivia_game.id }

        expect(response).to be_successful

        expect(json['prizes'].size).to eq(3)
        json['prizes'].each do |prize|
         expect(prize['photo_url']).not_to eq(nil)
        end
      end
    end
  end
end
