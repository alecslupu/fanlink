# frozen_string_literal: true

# == Schema Information
#
# Table name: step_completed
#
#  id         :bigint(8)        not null, primary key
#  step_id    :integer          not null
#  person_id  :integer          not null
#  status_old :text             default("0"), not null
#  quest_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("locked"), not null
#

class StepCompleted < ApplicationRecord
  enum status: %i[ locked unlocked completed ]
  has_paper_trail ignore: [:created_at, :updated_at]

  belongs_to :step, touch: true
  belongs_to :person, touch: true

  private
end
