# == Schema Information
#
# Table name: quest_completed
#
#  id         :bigint(8)        not null, primary key
#  quest_id   :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class QuestCompleted < ApplicationRecord
  enum status: %i[ completed ]

  belongs_to :quest
  belongs_to :person, touch: true


# default_scope { order(created_at: :desc) }
private
end
