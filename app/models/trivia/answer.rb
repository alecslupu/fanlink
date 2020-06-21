# frozen_string_literal: true

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
#  product_id         :integer          not null
#

module Trivia
  class Answer < ApplicationRecord
    has_paper_trail ignore: [:created_at, :updated_at]

    belongs_to :person, class_name: "Person"
    belongs_to :question, class_name: "Trivia::Question", foreign_key: :trivia_question_id

    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }
  end
end
