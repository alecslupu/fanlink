class PollOption < ApplicationRecord
include TranslationThings

  belongs_to :poll

  has_many :person_poll_options
  has_many :people, through: :person_poll_options, dependent: :destroy

  validates :description, uniqueness: {scope: :poll_id}
  validate :description_cannot_be_empty

  has_manual_translated :description
  
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
    if !description.present? || description.empty?
      errors.add(:description_error, "description can't be empty")
    end
  end
end
