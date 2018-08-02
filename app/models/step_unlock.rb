class StepUnlock < ApplicationRecord
private
  belongs_to :step, primary_key: :uuid, foreign_key: :step_id, touch: true
  has_one :unlock, class_name: "Step", primary_key: :unlock_id, foreign_key: :uuid
end
