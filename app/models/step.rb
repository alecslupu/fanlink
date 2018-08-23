class Step < ApplicationRecord
  include ActiveModel::Dirty

  belongs_to :quest, inverse_of: :steps, touch: true

  has_many :quest_activities, -> { order(created_at: :desc) }, dependent: :destroy, inverse_of: :step

  has_many :quest_completions, -> { where(person_id: Person.current_user.id) }, dependent: :destroy, class_name: "QuestCompletion", inverse_of: :step

  has_one :step_completed, -> { where(person_id: Person.current_user.id) }, class_name: "StepCompleted", inverse_of: :step

  has_many :assigned_rewards, as: :assigned, inverse_of: :step

  has_many :rewards, through: :assigned_rewards

  has_many :step_unlocks, primary_key: :uuid, foreign_key: :step_id

  enum initial_status: %i[ locked unlocked ]

  accepts_nested_attributes_for :quest_activities

  normalize_attributes :reward_id, :display

  attr_accessor :status

  #default_scope { order(created_at: :asc) }
  scope :get_requirement, -> (requirement) { where("step.id = ?", requirement) }
  scope :get_children, -> (step) { where("unlocks = ?", step.id) }
  scope :with_completions, -> (user) { includes(:quest_completions).where("quest_completions.person_id =?", user.id) }

private
end
