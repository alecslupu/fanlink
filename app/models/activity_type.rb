# frozen_string_literal: true
# == Schema Information
#
# Table name: activity_types
#
#  id          :bigint(8)        not null, primary key
#  activity_id :integer          not null
#  atype_old   :text
#  value       :jsonb            not null
#  deleted     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  atype       :integer          default("beacon"), not null
#

class ActivityType < ApplicationRecord
  include ActivityType::Beacon
  include ActivityType::Post
  include ActivityType::Image
  include ActivityType::Audio

  has_paper_trail ignore: [:created_at, :updated_at]

  enum atype: %i[ beacon image audio post activity_code ]
  belongs_to :quest_activity, foreign_key: :activity_id, inverse_of: :activity_types, touch: true

  validates :activity_id, presence: { message: _("Activity ID is required.") }
  validates_inclusion_of :atype, in: ActivityType.atypes.keys, message: _("%{value} is not a valid activity type.")
end
