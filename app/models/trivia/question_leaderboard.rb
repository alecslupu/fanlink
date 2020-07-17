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

module Trivia
  class QuestionLeaderboard < ApplicationRecord
    acts_as_tenant(:product)
    scope :for_product, ->(product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :question, class_name: 'Trivia::Question', foreign_key: :trivia_question_id
    belongs_to :person, class_name: 'Person'
  end
end
