# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trivia::Answer, type: :model do
  context 'Valid factory' do
    it { expect(build(:trivia_answer)).to be_valid }
  end
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#has_many' do
        should belong_to(:question)
        should belong_to(:person)
      end
    end
  end
end
