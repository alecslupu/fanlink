# frozen_string_literal: true
require "rails_helper"

RSpec.describe Trivia::Subscriber, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_subscriber)).to be_valid }
  end

  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#belongs_to" do
        should belong_to(:game)
        should belong_to(:person)
      end
    end
  end

  describe ".game_id" do
    it "matches the trivia game id" do
      subscriber = create :trivia_subscriber
      expect(subscriber.game_id).to eq(subscriber.trivia_game_id)
    end
  end
end
