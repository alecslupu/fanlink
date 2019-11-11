# == Schema Information
#
# Table name: trivia_topics
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer          not null
#

module Trivia
  class Topic < ApplicationRecord
    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }

    has_paper_trail

    enum status: %i[draft published locked closed]
    scope :published, -> { where(status: [:published, :locked, :closed]) }
  end
end
