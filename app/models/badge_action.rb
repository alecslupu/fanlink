class BadgeAction < ApplicationRecord
  belongs_to :action_type, counter_cache: true
  belongs_to :person, touch: true

  normalize_attributes :identifier

  validates :identifier, uniqueness: { scope: %i[ person_id action_type_id ],
                                       message: _("Sorry, you cannot get credit for that action again.") }, allow_nil: true
end
