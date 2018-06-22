class AssignedReward < ApplicationRecord
    belongs_to :assigned, polymorphic: true
    belongs_to :reward

    scope :by_type, ->(type) { where(assigned_type: type)}
    # scope :quest_badges, -> (badge) { by_type('Quest').badge(badge) }
    # scope :step_badges, -> (badge) { by_type('Step').badge(badge) }
    # scope :quest_activity_badges, -> (badge) { by_type('QuestActivity').badge(badge)}
end