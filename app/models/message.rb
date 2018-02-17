class Message < ApplicationRecord
  include AttachmentSupport
  enum status: %i[ pending posted ]

  belongs_to :person
  belongs_to :room

  has_image_called :picture
  has_many :message_reports, dependent: :destroy
  has_paper_trail

  scope :for_date_range, -> (room, from, to, limit = nil) { where(room: room).where("created_at >= ?", from.beginning_of_day).
                                                        where("created_at <= ?", to.end_of_day).order(created_at: :desc).limit(limit) }
  scope :for_product, -> (product) { joins(:room).where("rooms.product_id = ?", product.id) }
  scope :publics, -> { joins(:room).where("rooms.public = ?", true) }
  scope :unblocked, -> (blocked_users) { where.not(person_id: blocked_users) }
  scope :visible, -> { where(hidden: false) }

  def as_json
    super(only: [:id, :body, :picture_id], methods: [:create_time],
          include: { person: { only: [:id, :username, :name, :picture_id] } })
  end

  def create_time
    created_at.to_s
  end

  def product
    room.product
  end

  def reported?
    (message_reports.size > 0) ? "Yes" : "No"
  end

  def visible?
    !hidden
  end
end
