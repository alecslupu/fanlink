# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trivia::QuestionLeaderboard, type: :model do
  context 'Valid factory' do
    it { expect(build(:trivia_question_leaderboard)).to be_valid }
  end
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#has_many' do
        should belong_to(:question)
        should belong_to(:person)
      end
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
