class PersonReward < ActiveRecord
    belongs_to :reward
    belongs_to :person

    scope :steps_for_badge -> (badge) {inl}
    scope :quests_for_badge -> (badge) {}
    scope :quest_activities_for_badge -> (badge) {}
end