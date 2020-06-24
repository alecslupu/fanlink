# frozen_string_literal: true

# == Schema Information
#
# Table name: quest_activities
#
#  id                   :bigint(8)        not null, primary key
#  description_text_old :text
#  hint_text_old        :text
#  deleted              :boolean          default(FALSE)
#  activity_code        :string
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  picture_meta         :text
#  hint                 :jsonb            not null
#  description          :jsonb            not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  step_id              :integer          not null
#  reward_id            :integer
#  title                :jsonb            not null
#

class QuestActivity < ApplicationRecord
  has_paper_trail ignore: [:created_at, :updated_at]

  include AttachmentSupport

  translates :description, :name, :hint, :title, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  belongs_to :step, inverse_of: :quest_activities, touch: true

  has_many :quest_completions, -> { where(person_id: Person.current_user.id) }, dependent: :destroy, foreign_key: 'activity_id', inverse_of: :quest_activity
  has_many :activity_types, -> { order(created_at: :asc) }, dependent: :destroy, foreign_key: 'activity_id', inverse_of: :quest_activity
  has_many :assigned_rewards, as: :assigned, inverse_of: :quest_activity

  has_many :rewards, through: :assigned_rewards, source: :assigned, source_type: 'QuestActivity'

  has_image_called :picture

  accepts_nested_attributes_for :activity_types

  # default_scope { order(created_at: :desc) }

  scope :with_completion, ->(person) { where('quest_completions.person_id = ?', person.id) }

  def product
    step.quest.product
  end
end
