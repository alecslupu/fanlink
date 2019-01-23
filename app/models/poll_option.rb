class PollOption < ApplicationRecord
	belongs_to :poll

	has_many :person_poll_options
  has_many :people, through: :person_poll_options, dependent: :destroy

  validates :description, uniqueness: {scope: :poll_id}
  
  def voted?(person)
    people.present? && people.exists?(person.id)
  end

  def voters
    people
  end

	def votes
	  PersonPollOption.where(poll_option_id: self.id).count
	end
end
