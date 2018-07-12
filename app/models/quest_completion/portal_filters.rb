module QuestCompletion::PortalFilters
  extend ActiveSupport::Concern

  included do
    scope :id_filter, -> (query) { where(id: query.to_i) }
    scope :person_id_filter, -> (query) { where(person_id: query.to_i) }
    scope :person_filter, -> (query) { joins(:person).where("people.username_canonical ilike ? or people.email ilike ?", "%#{query}%", "%#{query}%") }
    scope :quest_id_filter, -> (query) { joins(:step).where('steps.quest_id = ?', query.to_i) }
    # scope :quest_filter, -> (query) { joins(:quest).where("quest.name ilike ?", "%#{query}%") }
    scope :activity_id_filter, -> (query) { where(activity_id: query.to_i) }
    scope :activity_filter, -> (query) { joins(:quest_activity).where("quest_activity.description ->>'en' ilike ? or quest_activity.description ->>'un' ilike ?", "%#{query}%", "%#{query}%") }
  end
end
