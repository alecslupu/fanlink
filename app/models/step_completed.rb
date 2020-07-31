# frozen_string_literal: true

# == Schema Information
#
# Table name: step_completed
#
#  id         :bigint           not null, primary key
#  step_id    :integer          not null
#  person_id  :integer          not null
#  status_old :text             default("0"), not null
#  quest_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("locked"), not null
#

class StepCompleted < ApplicationRecord
  enum status: { locked: 0, unlocked: 1, completed: 2 }

  belongs_to :step, touch: true
  belongs_to :person, touch: true
end
