# == Schema Information
#
# Table name: trivia_question_leaderboards
#
#  id                 :bigint(8)        not null, primary key
#  trivia_question_id :bigint(8)
#  nb_points          :integer
#  person_id          :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :trivia_question_leaderboard, class: "Trivia::QuestionLeaderboard" do
    trivia_question { nil }
    nb_points { 1 }
    person { nil }
  end
end
