# == Schema Information
#
# Table name: trivia_answers
#
#  id                 :bigint(8)        not null, primary key
#  person_id          :bigint(8)
#  trivia_question_id :bigint(8)
#  answered           :string
#  time               :integer
#  is_correct         :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

module Trivia
  class Answer < ApplicationRecord
    has_paper_trail
    belongs_to :person, class_name: "Person"
    belongs_to :question, class_name: "Trivia::Question", foreign_key: :trivia_question_id

    rails_admin do
      navigation_label "Answer"
    end
  end
end
