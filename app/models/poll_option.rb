# frozen_string_literal: true

# == Schema Information
#
# Table name: poll_options
#
#  id                        :bigint(8)        not null, primary key
#  poll_id                   :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  description               :jsonb            not null
#  person_poll_options_count :integer
#

class PollOption < ApplicationRecord

  belongs_to :poll

  has_many :person_poll_options
  has_many :people, through: :person_poll_options, dependent: :destroy

  validates :description, uniqueness: { scope: :poll_id }
  validate :description_cannot_be_empty

  translates :description, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  scope :for_product, -> (product) { joins(:poll).where(polls: { product_id: product.id }) }

  def voted?(person)
    people.present? && people.exists?(person.id)
  end

  def voters
    people
  end

  def votes
    person_poll_options.size
  end

  def description_cannot_be_empty
    if description.blank? || description.empty?
      errors.add(:description_error, "description can't be empty")
    end
  end
end
