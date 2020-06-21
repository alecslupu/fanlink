# frozen_string_literal: true

# == Schema Information
#
# Table name: steps
#
#  id             :bigint(8)        not null, primary key
#  quest_id       :integer          not null
#  display        :text
#  deleted        :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  int_unlocks    :integer          default([]), not null, is an Array
#  initial_status :integer          default("locked"), not null
#  reward_id      :integer
#  delay_unlock   :integer          default(0)
#  uuid           :uuid
#  unlocks        :text
#  unlocks_at     :datetime
#

class Step < ApplicationRecord
  has_paper_trail ignore: [:created_at, :updated_at]

  include ActiveModel::Dirty

  belongs_to :quest, inverse_of: :steps, touch: true

  has_many :quest_activities, -> { order(created_at: :desc) }, dependent: :destroy, inverse_of: :step

  has_many :quest_completions, -> { where(person_id: Person.current_user.id) }, dependent: :destroy, class_name: "QuestCompletion", inverse_of: :step

  has_one :step_completed, -> { where(person_id: Person.current_user.id) }, class_name: "StepCompleted", inverse_of: :step

  has_many :assigned_rewards, as: :assigned

  has_many :rewards, through: :assigned_rewards, source: :assigned, source_type: "Step"

  has_many :step_unlocks, primary_key: :uuid, foreign_key: :step_id

  enum initial_status: %i[locked unlocked]

  accepts_nested_attributes_for :quest_activities

  normalize_attributes :reward_id, :display

  attr_accessor :status

  # default_scope { order(created_at: :asc) }
  scope :get_requirement, -> (requirement) { where("step.id = ?", requirement) }
  scope :get_children, -> (step) { where("unlocks = ?", step.id) }
  scope :with_completions, -> (user) { includes(:quest_completions).where("quest_completions.person_id =?", user.id) }

private
end
