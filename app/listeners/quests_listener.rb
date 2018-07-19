class QuestsListener
  include Wisper::Publisher
  include RealTimeHelpers

  def self.completion_created(user, completion)
        puts "Completion detected. #{current_user.id}"
        step = Step.find(completion.step_id)
        if step.quest_completions.count >= step.quest_activities.count
          Rails.logger.tagged("[Step Completed]") { Rails.logger.info "Step #{step.id} for #{user.id} completed."} unless Rails.env.production?
            completed = StepCompleted.find_or_initialize_by({quest_id: step.quest_id, step_id: completion.step_id, person_id: user.id})
            completed.status = StepCompleted.statuses[:completed]
            if completed.valid?
              self.step_completed(user, completed)
              completed.save
              if step.step_unlocks.present?
                Rails.logger.tagged("[Completion Created]") { Rails.logger.info "Step has unlocks. Generating completed statuses for unlocks"} unless Rails.env.production?
                  step.step_unlocks.each do |unlock|
                      unlocked = StepCompleted.find_or_initialize_by({quest_id: step.quest_id, step_id: unlock.unlock.id, person_id: user.id})
                      unlocked.status = StepCompleted.statuses[:unlocked]
                      if unlocked.valid?
                        unlocked.save
                        # unlock.step.touch
                        # unlock.step.quest.touch
                      else
                        Rails.logger.tagged("[Completion Created]") { Rails.logger.error "Step: #{unlock.step.id} failed to save for User: #{user.id}"} unless Rails.env.production?
                      end
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
      StepUnlock.create(step_id: step.unlocks, unlock_id: step.uuid)
    end
  end

  def self.unlocks_updated(user, step)
    if !step.unlocks.empty?
      su = StepUnlock.find_or_initialize_by(unlock_id: step.uuid)
      su.step_id = step.unlocks
      if su.save
        Rails.logger.tagged("Unlock Update") { Rails.logger.info "Updated unlock for Step: #{step.id} to be unlocked by #{step.unlocks}"} unless Rails.env.production?
      else
        Rails.logger.tagged("Unlock Update") { Rails.logger.error "Failed to update previous unlock for Step: #{step.id} to be unlocked by #{step.unlocks}"} unless Rails.env.production?
      end
    else
      if StepUnlock.exists?(unlock_id: step.uuid)
        StepUnlock.find_by(unlock_id: step.uuid).delete
        Rails.logger.tagged("Unlock Update") { Rails.logger.error "Deleting unlock for Step: #{step.id}"} unless Rails.env.production?
      end
    end
  end
end
