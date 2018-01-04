class Message < ApplicationRecord

  belongs_to :person
  belongs_to :room

  validates :body, presence: { message: "Message body is required" }
  scope :visible, -> { where(hidden: false) }


  def as_json
    super(only: [:id, :body, :picture_id, :created_at],
          include: { person: { only: [:id, :username, :name, :picture_id]}})
  end


end