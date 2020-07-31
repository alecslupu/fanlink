# frozen_string_literal: true

# == Schema Information
#
# Table name: step_unlocks
#
#  id        :bigint           not null, primary key
#  step_id   :uuid             not null
#  unlock_id :uuid             not null
#

class StepUnlock < ApplicationRecord
  belongs_to :step, primary_key: :uuid, touch: true
  has_one :unlock, class_name: 'Step', primary_key: :unlock_id, foreign_key: :uuid
end
