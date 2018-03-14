class Message

  extend ActiveSupport::Concern

  module FilterrificImpl

    def self.included(base)
      base.class_exec do
        scope :person_name_query, -> (query)  { joins(:person).where( "people.name ilike ?", "%#{query}%") }
        scope :person_username_query, -> (query)  { joins(:person).where( "people.username_canonical ilike ?", "%#{query}%") }
        scope :room_query,   -> (query)  { joins(:room).where( "rooms.name_canonical ilike ?", "%#{query}%") }
        scope :id_query,     -> (query)  { where(id: query.to_i) }
        scope :body_query,   -> (query)  { where("messages.body ilike ?", "%#{query}%") }
        scope :sorted_by, lambda { |sort_option|
          direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
          case sort_option.to_s
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
          if reported == 'Yes'
            joins(:message_reports).where.not(message_reports: { message_id: nil } )
          elsif reported == 'No'
            includes(:message_reports).where(message_reports: { message_id: nil } )
          else
            nil
          end
        }

        filterrific(
            default_filter_params: { sorted_by: 'created_at desc' },
            available_filters: [
                :sorted_by,
                :person_username_query,
                :room_query,
                :id_query,
                :body_query,
                :with_reported_status
            ]
        )
      end
    end

    def self.options_for_reported_status_filter
      ["Any", "Yes", "No"]
    end

  end

end
