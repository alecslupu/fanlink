class QuestsListener
  include Wisper::Publisher
  include RealTimeHelpers

  def self.completion_created(user, completion)
        puts "Completion detected."
        step = Step.find(completion.step_id)
        puts "#{step.inspect}"
        if step.quest_completions.count === step.quest_activities.count
            puts "Step completed."
            completed = StepCompleted.find_or_initialize_by({quest_id: step.quest_id, step_id: completion.step_id, person_id: user.id})
            completed.status = StepCompleted.statuses[:completed]
            if completed.valid?
              self.step_completed(user, completed)
              completed.save
              if step.unlocks.present?
                  puts "Step has unlocks. Generating completed statuses for unlocks"
                  step.unlocks.each do |unlock|
                      unlocked = StepCompleted.create({quest_id: step.quest_id, step_id: unlock, person_id: user.id, status: StepCompleted.statuses[:unlocked]})
                  end
              end
          end
      end
  end

  def self.step_completed(user, step)
    total_steps = Quest.find(step.quest_id).steps.count
    completed_steps = StepCompleted.where(quest_id: step.quest_id, person_id: user.id).count
    if total_steps == completed_steps
      completed = QuestCompleted.find_or_initialize_by(person_id: user.id, quest_id: step.quest_id)
      if completed.valid?
        completed.save
      end
    end
  end

  def self.step_created(user, step)
    if step.unlocks.present?
      StepUnlock.create(step_id: Step.find(step.unlocks).uuid, unlock_id: s.uuid)
    end
  end

  def self.unlocks_updated(user, step)
    if !step.unlocks.empty?
        su = StepUnlock.find_or_initialize_by(unlock_id: step.uuid)
        su.step_id = step.unlocks
        if su.save
          Rails.logger.tagged("Unlock Update") { Rails.logger.info "Updated unlock for Step: #{step.id} to be unlocked by #{step.unlocks}"}
        else
          Rails.logger.tagged("Unlock Update") { Rails.logger.error "Failed to update previous unlock for Step: #{step.id} to be unlocked by #{step.unlocks}"}
        end
      else
        if StepUnlock.exists?(unlock_id: step.uuid)
          StepUnlock.find_by(unlock_id: step.uuid).delete
          Rails.logger.tagged("Unlock Update") { Rails.logger.error "Deleting unlock for Step: #{step.id}"}
        end
      end
  end
end
