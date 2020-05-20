# frozen_string_literal: true
# == Schema Information
#
# Table name: quest_completions
#
#  id          :bigint(8)        not null, primary key
#  person_id   :integer          not null
#  activity_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status_old  :text             default("0"), not null
#  step_id     :integer          not null
#  status      :integer          default("locked"), not null
#

class QuestCompletion < ApplicationRecord
  # include QuestCompletion::PortalFilters

  scope :id_filter, -> (query) { where(id: query.to_i) }
  scope :person_id_filter, -> (query) { where(person_id: query.to_i) }
  scope :person_filter, -> (query) { joins(:person).where("people.username_canonical ilike ? or people.email ilike ?", "%#{query}%", "%#{query}%") }
  scope :quest_id_filter, -> (query) { joins(:step).where("steps.quest_id = ?", query.to_i) }
  # scope :quest_filter, -> (query) { joins(:quest).where("quest.name ilike ?", "%#{query}%") }
  scope :activity_id_filter, -> (query) { where(activity_id: query.to_i) }
  scope :activity_filter, -> (query) { joins(:quest_activity).where("quest_activity.description ->>'en' ilike ? or quest_activity.description ->>'un' ilike ?", "%#{query}%", "%#{query}%") }

  # include QuestCompletion::PortalFilters

  enum status: %i[ locked unlocked completed ]

  belongs_to :step, touch: true
  belongs_to :person, touch: true
  belongs_to :quest_activity, foreign_key: "activity_id"

  validates :person_id, presence: { message: _("Person ID is not being automatically set.") }
  validates :activity_id, presence: { message: _("Activity ID is required.") }

  # default_scope { order(created_at: :desc) }
  scope :count_activity, -> (step_id) { where(step_id: step_id).count }

private
end
