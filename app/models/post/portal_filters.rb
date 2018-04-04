module Post::PortalFilters
  extend ActiveSupport::Concern

  included do
    scope :person_id_filter, -> (query) { where(person_id: query.to_i) }
    scope :person_filter, -> (query) { joins(:person).where( "people.username_canonical ilike ? or people.email ilike ?", "%#{query}%", "%#{query}%") }
    scope :body_filter, -> (query) { where("posts.body->>'en' ilike ? or posts.body->>'un' ilike ?", "%#{query}%", "%#{query}%") }
    scope :posted_after_filter, -> (query) { where("posts.created_at >= ?", Time.parse(query)) }
    scope :posted_before_filter, -> (query) { where("posts.created_at <= ?", Time.parse(query)) }
    scope :status_filter, -> (query) { where(status: query.to_sym) }
  end
end
