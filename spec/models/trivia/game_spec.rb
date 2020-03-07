require "rails_helper"

RSpec.describe Trivia::Game, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_game)).to be_valid }
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should belong_to(:product)
        should belong_to(:room)
        should have_many(:rounds)
        should have_many(:prizes)
        should have_many(:leaderboards)
      end
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"

  context "full game" do
    it "has a full valid game on-going" do
      ActsAsTenant.with_tenant(create(:product)) do
        create(:full_trivia_game, with_leaderboard: false)

        last_game = Trivia::Game.last
        expect(last_game.rounds.size).to eq(7)
        expect(last_game.prizes.size).to eq(3)
      end
    end
  end

  context "status" do
    subject { Trivia::Game.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:running?) }

    it { expect(subject).to respond_to(:closed?) }
  end

  context "State Machine" do
    subject { Trivia::Game.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:running).on_event(:running) }
    it { expect(subject).to transition_from(:running).to(:closed).on_event(:closed) }
  end


  context "scheduled round" do
    describe ".compute_gameplay_parameters" do
      it "has the method" do
        expect(Trivia::Game.new.respond_to?(:compute_gameplay_parameters)).to eq(true)
      end
      it "sets the start_date of a question" do
        time = DateTime.now.to_i
        game = create(:full_trivia_game, start_date: time, with_leaderboard: false)
        stub_request(:post, "https://stg-fl-trivia.herokuapp.com/api/publish_game")
          .with(
            body: "{\"game_id\":#{game.id}}",
            headers: {
              "Accept-Encoding" => "application/javascript",
              "Content-Type" => "application/json",
              "Trivia-Api-Key" => "testing",
            }
          )
          .to_return(status: 200, body: "", headers: {})

        game.compute_gameplay_parameters
        round = game.reload.rounds.first
        expect(round.start_date).to be_within(1.seconds).of game.start_date
      end

      it "sets any question at the right interval" do
        time = DateTime.now.to_i
        game = create(:full_trivia_game, start_date: time, with_leaderboard: false)
        stub_request(:post, "https://stg-fl-trivia.herokuapp.com/api/publish_game")
          .with(
            body: "{\"game_id\":#{game.id}}",
            headers: {
              "Accept-Encoding" => "application/javascript",
              "Content-Type" => "application/json",
              "Trivia-Api-Key" => "testing",
            }
          )
          .to_return(status: 200, body: "", headers: {})

        game.compute_gameplay_parameters
        expect(game.end_date - game.rounds.last.end_date).to eq(0)
      end

      it "sets any question at the right interval" do
        time = DateTime.now.to_i
        game = create(:full_trivia_game, start_date: time, with_leaderboard: false)
        stub_request(:post, "https://stg-fl-trivia.herokuapp.com/api/publish_game")
          .with(
            body: "{\"game_id\":#{game.id}}",
            headers: {
              "Accept-Encoding" => "application/javascript",
              "Content-Type" => "application/json",
              "Trivia-Api-Key" => "testing",
            }
          )
          .to_return(status: 200, body: "", headers: {})

        create(:trivia_round, game: game)
        game.compute_gameplay_parameters
        expect(game.end_date - game.rounds.reload.last.end_date).to eq(0)
      end
      it "sets the end date correctly on round" do
        time = DateTime.now.to_i
        game = create(:full_trivia_game, start_date: time, with_leaderboard: false)
        stub_request(:post, "https://stg-fl-trivia.herokuapp.com/api/publish_game")
          .with(
            body: "{\"game_id\":#{game.id}}",
            headers: {
              "Accept-Encoding" => "application/javascript",
              "Content-Type" => "application/json",
              "Trivia-Api-Key" => "testing",
            }
          )
          .to_return(status: 200, body: "", headers: {})

        game.compute_gameplay_parameters

        round = game.rounds.reload.last
        expect(game.end_date).to be_within(1.seconds).of round.end_date
      end
    end
  end

  describe "copy_to_new" do
    it "has the method" do
      expect(Trivia::Game.new.respond_to?(:copy_to_new)).to eq(true)
    end
    context "new Game" do
      before do
        time = DateTime.now.to_i
        old_game = create(:full_short_trivia_game, start_date: time, with_leaderboard: false, status: :closed)
        expect(Trivia::Game.count).to eq(1)
        @old_game = Trivia::Game.includes(:prizes, :rounds).last
        @game_object = @old_game.copy_to_new


        expect(Trivia::Game.count).to eq(2)
      end

      it { expect(@game_object).to be_a(Trivia::Game) }
      it { expect(@game_object.status).to eq("draft") }
      it { expect(@game_object.start_date).to be_nil }
      it { expect(@game_object.end_date).to be_nil }
      it { expect(@game_object.prizes.size).to eq(@old_game.prizes.length) }
      it { expect(@game_object.rounds.size).to eq(@old_game.rounds.length) }
    end
  end
end
