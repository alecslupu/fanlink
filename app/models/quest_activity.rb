class QuestActivity < ApplicationRecord
  include AttachmentSupport
  include TranslationThings

  has_manual_translated :description, :name, :hint, :title
  belongs_to :step, inverse_of: :quest_activities, touch: true

  has_many :quest_completions, -> { where(person_id: Person.current_user.id) }, dependent: :destroy, foreign_key: "activity_id", inverse_of: :quest_activity
  has_many :activity_types, -> { order(created_at: :asc) }, dependent: :destroy, foreign_key: "activity_id", inverse_of: :quest_activity
  has_many :assigned_rewards, as: :assigned, inverse_of: :quest_activity

  has_many :rewards, through: :assigned_rewards, source: :assigned, source_type: "QuestActivity"

  has_image_called :picture

  accepts_nested_attributes_for :activity_types


  # default_scope { order(created_at: :desc) }


  scope :with_completion, -> (person) { where("quest_completions.person_id = ?", person.id) }

  def product
    step.quest.product
  end
end
