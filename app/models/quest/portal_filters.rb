module Quest::PortalFilters
  extend ActiveSupport::Concern

  included do
    scope :id_filter, -> (query) { where(id: query.to_i) }
    scope :product_id_filter, -> (query) { where(product_id: query.to_i) }
    scope :product_filter, -> (query) { joins(:product).where("product.internal_name ilike ? or product.name ilike ?", "%#{query}%", "%#{query}%") }
    scope :name_filter, -> (query) { where("quests.name->>'en' ilike ? or quests.name->>'un' ilike ?", "%#{query}%", "%#{query}%") }
    scope :description_filter, -> (query) { where("quests.description->>'en' ilike ? or quests.descriptions->>'un' ilike ?", "%#{query}%", "%#{query}%") }
    scope :starts_at_filter, -> (query) { where("quests.starts_at >= ?", Time.parse(query)) }
    scope :ends_at_filter, -> (query) { where("quests.ends_at <= ?", Time.parse(query)) }
    scope :posted_after_filter, -> (query) { where("quests.created_at >= ?", Time.parse(query)) }
    scope :posted_before_filter, -> (query) { where("quests.created_at <= ?", Time.parse(query)) }
    scope :status_filter, -> (query) { where(status: query.to_sym) }
  end
end
