require 'rails_helper'

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

  context "scheduled round" do
    describe ".compute_gameplay_parameters" do
      it "has the method" do
        expect(Trivia::Game.new.respond_to?(:compute_gameplay_parameters)).to eq(true)
      end
      it "sets the start_date of a question" do
        time = DateTime.now.to_i
        game = create(:full_trivia_game, start_date: time, with_leaderboard: false)
        game.compute_gameplay_parameters
        round = game.reload.rounds.first
        expect(round.start_date).to be_within(1.seconds).of game.start_date
        expect(round.round_order).to eq(1)
      end

      it "sets any question at the right interval" do
        time = DateTime.now.to_i
        game = create(:full_trivia_game, start_date: time, with_leaderboard: false)
        game.compute_gameplay_parameters
        expect(game.end_date - game.rounds.last.end_date).to eq(0)
      end

      it "sets any question at the right interval" do
        time = DateTime.now.to_i
        game = create(:full_trivia_game, start_date: time, with_leaderboard: false)
        create(:trivia_round, game: game)
        game.compute_gameplay_parameters
        expect(game.end_date - game.rounds.reload.last.end_date).to eq(0)
      end
      it "sets the end date correctly on round" do
        time = DateTime.now.to_i
        game = create(:full_trivia_game, start_date: time, with_leaderboard: false)
        game.compute_gameplay_parameters

        round = game.rounds.reload.last
        expect(game.end_date).to be_within(1.seconds).of round.end_date
      end
    end
  end
end

