# == Schema Information
#
# Table name: trivia_answers
#
#  id                 :bigint(8)        not null, primary key
#  person_id          :bigint(8)
#  trivia_question_id :bigint(8)
#  answered           :string
#  time               :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_correct         :boolean          default(FALSE)
#

module Trivia
  class Answer < ApplicationRecord
    has_paper_trail
    belongs_to :person, class_name: "Person"
    belongs_to :question, class_name: "Trivia::Question", foreign_key: :trivia_question_id
  end
end
