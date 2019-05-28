# == Schema Information
#
# Table name: trivia_available_answers
#
#  id                 :bigint(8)        not null, primary key
#  trivia_question_id :bigint(8)
#  name               :string
#  hint               :string
#  is_correct         :boolean          default(FALSE), not null
#  status             :integer          default("draft"), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

module Trivia
  class AvailableAnswer < ApplicationRecord
    has_paper_trail
    belongs_to :question, class_name: "Trivia::AvailableQuestion", foreign_key: :trivia_question_id
    enum status: %i[draft published locked closed]
  end
end
