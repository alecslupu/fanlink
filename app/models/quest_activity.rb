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

  translates :description, :name, :hint, :title, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  belongs_to :step, inverse_of: :quest_activities, touch: true

  has_many :quest_completions, -> { where(person_id: Person.current_user.id) }, dependent: :destroy, foreign_key: "activity_id", inverse_of: :quest_activity
  has_many :activity_types, -> { order(created_at: :asc) }, dependent: :destroy, foreign_key: "activity_id", inverse_of: :quest_activity
  has_many :assigned_rewards, as: :assigned, inverse_of: :quest_activity

  has_many :rewards, through: :assigned_rewards, source: :assigned, source_type: "QuestActivity"

  has_one_attached :picture

  validates :picture, size: {less_than: 5.megabytes},
            content_type: {in: %w[image/jpeg image/gif image/png]}

  def picture_url
    picture.attached? ? [Rails.application.secrets.cloudfront_url, picture.key].join('/') : nil
  end

  def picture_optimal_url
    opts = { resize: "1000", auto_orient: true, quality: 75}
    picture.attached? ? [Rails.application.secrets.cloudfront_url, picture.variant(opts).processed.key].join('/') : nil
  end

  def picture_width
    picture.attached? ? picture.blob.metadata[:width] : nil
  end

  def picture_height
    picture.attached? ? picture.blob.metadata[:height] : nil
  end

  accepts_nested_attributes_for :activity_types

  scope :with_completion, -> (person) { where("quest_completions.person_id = ?", person.id) }

  def product
    step.quest.product
  end
end
