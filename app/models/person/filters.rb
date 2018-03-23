module Person::Filters
  extend ActiveSupport::Concern

  included do
    scope :username_filter, -> (query) { where( "people.username_canonical ilike ?", "%#{query}%") }
    scope :email_filter,    -> (query) { where( "people.email ilike ?", "%#{query}%") }
  end
end
