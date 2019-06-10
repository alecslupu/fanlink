# == Schema Information
#
# Table name: trivia_question_leaderboards
#
#  id                 :bigint(8)        not null, primary key
#  trivia_question_id :bigint(8)
#  points             :integer
#  person_id          :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :trivia_question_leaderboard, class: "Trivia::QuestionLeaderboard" do
    question { create(:trivia_single_choice_question) }

    points { 1 }
    person { create(:person) }
  end
end
