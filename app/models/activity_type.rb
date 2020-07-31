# frozen_string_literal: true

# == Schema Information
#
# Table name: activity_types
#
#  id          :bigint           not null, primary key
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

  enum atype: { beacon: 0, image: 1, audio: 2, post: 3, activity_code: 4 }
  belongs_to :quest_activity, foreign_key: :activity_id, inverse_of: :activity_types, touch: true

  validates :activity_id, presence: { message: _('Activity ID is required.') }
  validates :atype, inclusion: { in: ActivityType.atypes.keys, message: _('%{value} is not a valid activity type.') }
end
