# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_round_leaderboards
#
#  id              :bigint           not null, primary key
#  trivia_round_id :bigint
#  points          :integer
#  position        :integer
#  person_id       :bigint
#  average_time    :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :integer          not null
#


require 'rails_helper'

RSpec.describe Trivia::RoundLeaderboard, type: :model do
  context 'Valid factory' do
    it { expect(build(:trivia_round_leaderboard)).to be_valid }
  end
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#has_many' do
        should belong_to(:round)
        should belong_to(:person)
      end
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
