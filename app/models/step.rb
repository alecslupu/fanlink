class Step < ApplicationRecord
    belongs_to :quest
    has_many :quest_activities, -> { order(created_at: :desc) }
    has_many :quest_completions, -> { where(person_id: Person.current_user.id) }, class_name: "QuestCompletion"
    has_one :step_completed, -> { where(person_id: Person.current_user.id) }, class_name: "StepCompleted"

    enum initial_status: %i[ locked unlocked ]


    attr_accessor :status

    default_scope { order(created_at: :asc) }
    scope :get_requirement, -> (requirement) { where('step.id = ?', requirement) }
    scope :get_children, -> (step) { where('unlocks = ?', step.id) }
    
private
    
end