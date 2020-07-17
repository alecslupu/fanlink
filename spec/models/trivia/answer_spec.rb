# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_answers
#
#  id                 :bigint           not null, primary key
#  person_id          :bigint
#  trivia_question_id :bigint
#  answered           :string
#  time               :integer
#  is_correct         :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#


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
