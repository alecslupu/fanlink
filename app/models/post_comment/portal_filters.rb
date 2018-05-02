module PostComment::PortalFilters
  extend ActiveSupport::Concern

  included do
    scope :person_filter, -> (query) { joins(:person).where("people.username_canonical ilike ? or people.email ilike ?", "%#{query}%", "%#{query}%") }
    scope :body_filter, -> (query) { where("post_comments.body ilike ?", "%#{query}%") }
  end
end
