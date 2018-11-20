class Message < ApplicationRecord
  include AttachmentSupport
  include Message::FilterrificImpl
  include Message::PortalFilters
  include Message::RealTime

  #replicated_model

  enum status: %i[ pending posted ]

  normalize_attributes :body

  belongs_to :person, touch: true
  belongs_to :room, touch: true

  has_image_called :picture
  has_audio_called :audio

  has_many :message_mentions, dependent: :destroy
  has_many :message_reports, dependent: :destroy
  has_paper_trail

  scope :for_date_range, -> (room, from, to, limit = nil) {
          where(room: room).where("created_at >= ?", from.beginning_of_day).
            where("created_at <= ?", to.end_of_day).order(created_at: :desc).limit(limit)
        }
  scope :for_product, -> (product) { joins(:room).where("rooms.product_id = ?", product.id) }
  scope :pinned, -> (param) { joins(:person).where("people.pin_messages_from = ?", (param.downcase == "yes") ? true : false) }
  scope :publics, -> { joins(:room).where("rooms.public = ?", true) }
  scope :reported_action_needed, -> { joins(:message_reports).where("message_reports.status = ?", MessageReport.statuses[:pending]) }
  scope :unblocked, -> (blocked_users) { where.not(person_id: blocked_users) }
  scope :visible, -> { where(hidden: false) }
  scope :room_date_range, -> (from,to) { where("messages.created_at BETWEEN ? AND ?", from, to)}

  def as_json
    super(only: %i[ id body picture_id ], methods: %i[ create_time picture_url pinned ],
          include: { message_mentions: { except: %i[ message_id ] },
                    person: { only: %i[ id username name designation product_account chat_banned badge_points
                                       level do_not_message_me pin_messages_from ], methods: %i[ level picture_url ] } })
  end

  def create_time
    created_at.to_s
  end

  def mentions
    message_mentions
  end

  def mentions=(mention_params)
    mention_params.each do |mp|
      message_mentions.build(person_id: mp[:person_id], location: mp[:location].to_i, length: mp[:length].to_i)
    end
  end

  def name
    person.name
  end

  def product
    room.product
  end

  def reported?
    (message_reports.size > 0) ? "Yes" : "No"
  end

  def username
    person.username
  end

  def visible?
    !hidden
  end

  def parse_tags
    if body.match?(/\[([^\]]+)\]/i)
      parsed = []
      body.scan(/\[([^\]]+)\]/i) {|m| parsed << m.first.split('|') }
      parsed.each {|p|
        body_str = p.join('|')
        case p[0]
        when "m"
          person_id = People.where(username: p[1].trim('@', '')).first.id
          body_str = p.join('|')
          message_mentions.build(person_id: person_id, location: body.index("[#{body_str}]"), length: p[1].size)
          body.sub!("[#{body_str}]", p[1])
        else
          body.sub!("[#{body_str}]", p[1])
        end
      }

  def pinned
    PinMessage.where(person_id: person.id, room_id: room.id).exists? || person.product_account?
  end
end
