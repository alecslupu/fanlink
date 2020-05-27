# frozen_string_literal: true
# == Schema Information
#
# Table name: messages
#
#  id                   :bigint(8)        not null, primary key
#  person_id            :integer          not null
#  room_id              :integer          not null
#  body                 :text
#  hidden               :boolean          default(FALSE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  status               :integer          default("pending"), not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  audio_file_name      :string
#  audio_content_type   :string
#  audio_file_size      :integer
#  audio_updated_at     :datetime
#

class Message < ApplicationRecord
  include AttachmentSupport
  # include Message::FilterrificImpl

  scope :person_name_query, -> (query)  { joins(:person).where("people.name ilike ?", "%#{query}%") }
  scope :person_username_query, -> (query)  { joins(:person).where("people.username_canonical ilike ?", "%#{query}%") }
  scope :room_query,   -> (query)  { joins(:room).where("rooms.name->>'en' ilike ? or rooms.name->>'un' ilike ?", "%#{query}%", "%#{query}%") }
  scope :id_query,     -> (query)  { where(id: query.to_i) }
  scope :body_query,   -> (query)  { where("messages.body ilike ?", "%#{query}%") }
  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? "desc" : "asc"
    case sort_option.to_s
    when /^created/
      order("created_at #{direction}")
    when /^person/
      joins(:person).order("LOWER(people.username) #{ direction }")
    when /^room/
      joins(:room).order("LOWER(rooms.name) #{direction}")
    when /^id/
      order("id #{direction}")
    when /^body/
      order("body #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_reported_status, lambda { |reported|
    if reported == "Yes"
      joins(:message_reports).where.not(message_reports: { message_id: nil })
    elsif reported == "No"
      left_outer_joins(:message_reports).where(message_reports: { message_id: nil })
    else
      nil
    end
  }

  # filterrific(
  #   default_filter_params: { sorted_by: "created_at desc" },
  #   available_filters: [
  #     :sorted_by,
  #     :person_username_query,
  #     :room_query,
  #     :id_query,
  #     :body_query,
  #     :with_reported_status
  #   ]
  # )

  def self.options_for_reported_status_filter
    %w(Any Yes No)
  end
  # include Message::FilterrificImpl
  # include Message::PortalFilters

  scope :id_filter, -> (query) { where(id: query.to_i) }
  scope :person_filter, -> (query) { joins(:person).where("people.username_canonical ilike ?", "%#{query}%") }
  scope :room_id_filter, -> (query) { joins(:room).where("rooms.id = ?", query.to_i) }
  scope :body_filter, -> (query) { where("body ilike ?", "%#{query}%") }
  scope :created_after_filter, -> (query) { where("messages.created_at > ?", query) }
  scope :created_before_filter, -> (query) { where("messages.created_at < ?", query) }

  scope :reported_filter, lambda { |reported|
    if reported == "Yes"
      joins(:message_reports).where.not(message_reports: { message_id: nil })
    elsif reported == "No"
      joins(:message_reports).where(message_reports: { message_id: nil })
    else
      nil
    end
  }
  # include Message::PortalFilters
  # include Message::RealTime
  def delete_real_time(version = 0)
    DeleteMessageJob.perform_later(id, version)
  end

  def post(version = 0)
    PostMessageJob.perform_later(self.id, version)

    message_mentions.each do |mention|
      MessageMentionPushJob.perform_later(mention.id)
    end
  end

  def private_message_push
    PrivateMessagePushJob.perform_later(id)
  end

  def public_room_message_push
    if RoomSubscriber.where(room_id: room.id).where("last_notification_time < ?", DateTime.current - 2.minute).where.not(person_id: person_id).exists?
      PublicMessagePushJob.perform_later(id)
    end
  end

  # include Message::RealTime

  # replicated_model

  enum status: %i[ pending posted ]

  normalize_attributes :body

  attr_accessor :mention_meta

  belongs_to :person, touch: true
  belongs_to :room, touch: true

  has_image_called :picture
  has_audio_called :audio

  has_many :message_mentions, dependent: :destroy
  has_many :message_reports, dependent: :destroy
  has_many :room_subscribers, dependent: :nullify

  has_paper_trail ignore: [:created_at, :updated_at]

  scope :for_date_range, -> (room, from, to, limit = nil) {
          where(room: room).where("created_at >= ?", from.beginning_of_day).
            where("created_at <= ?", to.end_of_day).order(created_at: :desc).limit(limit)
        }
  scope :for_product, ->(product) { joins(:room).where( rooms: { product_id: product.id }) }
  scope :pinned, ->(param) { joins(:person).where( people: { pin_messages_from: (param.downcase == "yes") } ) }
  scope :publics, -> { joins(:room).where( rooms: { public: true } ) }
  scope :reported_action_needed, -> { joins(:message_reports).where( message_reports: { status: MessageReport.statuses[:pending] } ) }
  scope :unblocked, ->(blocked_users) { where.not(person_id: blocked_users) }

  scope :not_reported_by_user, -> (person_id) {
    where("NOT EXISTS (
      SELECT 1 FROM message_reports
      WHERE message_reports.message_id = messages.id
      AND message_reports.person_id = ?
    )", person_id)
  }

  scope :visible, -> { where(hidden: false) }
  scope :room_date_range, -> (from, to) { where("messages.created_at BETWEEN ? AND ?", from, to) }
  scope :chronological, ->(sign, created_at, id) { sign == '>' ? after_message(created_at, id) : before_message(created_at, id) }
  scope :after_message, ->(created_at, id) { where("messages.created_at > ? AND messages.id > ?", created_at, id) }
  scope :before_message, ->(created_at, id) { where("messages.created_at < ? AND messages.id < ?", created_at, id) }

  scope :reported, -> { joins(:message_reports) }
  scope :not_reported, -> { left_joins(:message_reports).where(message_reports: { id: nil } ) }

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
    person.try(:name)
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

  def parse_content(version = 4)
    mmeta = []
    if body.present?
      if version <= 3
        if body.match?(/\[([A-Za-z0-9])\|/i)
          body.gsub!(/\[m\|(.+?)\]/i, '@\1')
          body.gsub!(/\[q\|([^\|\]]*)\]/i) { |m| "\u201C#{$1}\u201D" }
        end
        if body.match?(/[^\u201C]*@\w{3,26}[^\u201D]*/i)
          mod_body = body
          body.scanm(/[^\u201C]*(@\w{3,26})[^\u201D]*/i).each { |m|
            person = Person.where(username: m[1].sub("@", "")).first
            if person.present?
              # self.mention_meta.push({ person_id: person.id, location: mod_body.index(m[1]), length: m[1].size })
              mmeta << { id: MessageMention.maximum(:id) + rand(200 - 1000), person_id: person.id, location: mod_body.index(m[1]), length: m[1].size }
              mod_body = mod_body.sub(m[1], "a" * m[1].size)
            end
          }
        end
        # else
        #   body.gsub!(/(@([A-Za-z0-9]+))/) { |m| m.gsub!($1, "[m|#{$2}]")}
      end
    end
    self.mention_meta = mmeta
    body
  end

  def pinned
    PinMessage.where(person_id: person.id, room_id: room.id).exists? || person.product_account? || person.pin_messages_from?
  end
end
