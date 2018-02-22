class BadgeAction < ApplicationRecord
  belongs_to :action_type
  belongs_to :person

  validates :identifier, uniqueness: { scope: %i[ person_id action_type_id ],
                                       message: "Sorry, you cannot get credit for that action again." }, allow_nil: true
end
