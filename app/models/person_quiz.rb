# frozen_string_literal: true

# == Schema Information
#
# Table name: person_quizzes
#
#  id               :bigint(8)        not null, primary key
#  person_id        :integer          not null
#  quiz_page_id     :integer          not null
#  answer_id        :integer
#  fill_in_response :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class PersonQuiz < ApplicationRecord
  has_paper_trail ignore: [:created_at, :updated_at]

  belongs_to :person
  belongs_to :quiz_page
  belongs_to :answer
  scope :for_product, -> (product) { joins(:person).where(people: { product_id: product.id }) }
end
