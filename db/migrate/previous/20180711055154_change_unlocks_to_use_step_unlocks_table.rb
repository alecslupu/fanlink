class ChangeUnlocksToUseStepUnlocksTable < ActiveRecord::Migration[5.1]
  def up
    Step.all.each do |s|
      su = []
      if s.int_unlocks.any?
        s.int_unlocks.each do |unlock|
          if Step.exists?(unlock)
            step = Step.find(unlock)
            step.unlocks = s.uuid
            StepUnlock.create(step_id: s.uuid, unlock_id: step.uuid)
            step.save
          else
            puts "Invalid unlock ID for Step: #{s.id}"
          end
        end
      end
    end
  end

  def down

  end
end
