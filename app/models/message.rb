class Message < ApplicationRecord
  belongs_to :person
  belongs_to :room

  validates :body, presence: { message: "Message body is required" }

  scope :for_date_range, -> (room, from, to, limit = nil) { where(room: room).where("created_at >= ?", from.beginning_of_day).
                                                        where("created_at <= ?", to.end_of_day).order(created_at: :desc).limit(limit) }
  scope :visible, -> { where(hidden: false) }


  def as_json
    super(only: [:id, :body, :picture_id], methods: [:create_time],
          include: { person: { only: [:id, :username, :name, :picture_id] } })
  end

  def create_time
    created_at.to_s
  end

  def visible?
    !hidden
  end
end
