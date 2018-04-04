module Post::PortalFilters
  extend ActiveSupport::Concern

  included do
    scope :person_id_filter, -> (query) { where(person_id: query.to_i) }
    scope :person_filter, -> (query) { joins(:person).where( "people.username_canonical ilike ? or people.email ilike ?", "%#{query}%", "%#{query}%") }
    # scope :room_id_filter, -> (query) { joins(:room).where("rooms.id = ?", query.to_i) }
    # scope :body_filter, -> (query) { where("body ilike ?", "%#{query}%") }
    #
    # scope :reported_filter, lambda { |reported|
    #   if reported == 'Yes'
    #     joins(:message_reports).where.not(message_reports: { message_id: nil } )
    #   elsif reported == 'No'
    #     joins(:message_reports).where(message_reports: { message_id: nil } )
    #   else
    #     nil
    #   end
    # }
  end
end
