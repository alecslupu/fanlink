# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_question_leaderboards
#
#  id                 :bigint           not null, primary key
#  trivia_question_id :bigint
#  points             :integer
#  person_id          :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#

FactoryBot.define do
  factory :trivia_question_leaderboard, class: 'Trivia::QuestionLeaderboard' do
    question { create(:trivia_single_choice_question) }
    product { current_product }

    points { 1 }
    person { create(:person) }
  end
end
