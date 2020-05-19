# frozen_string_literal: true
require "spec_helper"

describe Trivia::GameGenerator do
  describe "#generate" do
    it "creates a draft game" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        generator = Trivia::GameGenerator.new
        create_list(:trivia_multiple_choice_available_question, 100)
        expect { generator.generate }.to change { Trivia::Game.count }.by(1)
        expect { generator.generate }.to change { Trivia::Round.count }.by(5)
        expect { generator.generate }.to change { Trivia::Question.count }.by(250)
      end
    end
  end
  describe "promote" do
    it "creates a draft game" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        generator = Trivia::GameGenerator.new
        create_list(:trivia_multiple_choice_available_question, 100)

        generator.generate
        stub_request(:post, "https://stg-fl-trivia.herokuapp.com/api/publish_game")
          .with(
            body: "{\"game_id\":#{generator.game.id}}",
            headers: {
              "Accept-Encoding" => "application/javascript",
              "Content-Type" => "application/json",
              "Trivia-Api-Key" => "testing"
            }
          )
          .to_return(status: 200, body: "", headers: {})

        expect(generator.game).to receive(:handle_status_changes).exactly(1).times
        generator.promote!
      end
    end
  end
end
