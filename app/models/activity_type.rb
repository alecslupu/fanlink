class ActivityType < ApplicationRecord
  include ActivityType::Beacon
  include ActivityType::Post
  include ActivityType::Image
  include ActivityType::Audio


  enum atype: %i[ beacon image audio post activity_code ]
  belongs_to :quest_activity, foreign_key: "activity_id", inverse_of: :activity_types, touch: true

  validates_inclusion_of :atype, in: ActivityType.atypes.keys, message: _("%{value} is not a valid activity type.")

private
end
