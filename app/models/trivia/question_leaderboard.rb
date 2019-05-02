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
module Trivia

  class QuestionLeaderboard < ApplicationRecord
    belongs_to :question, class_name: "Trivia::Question", foreign_key: :trivia_question_id
    belongs_to :person, class_name: "Person"
  end
end
