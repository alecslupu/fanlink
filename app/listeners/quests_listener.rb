# frozen_string_literal: true
class QuestsListener
  include Wisper::Publisher
  include RealTimeHelpers

  def self.completion_created(user, completion)
    puts "Completion detected. #{Person.current_user.id}"
    step = Step.find(completion.step_id)
    if step.quest_completions.count >= step.quest_activities.where(deleted: false).count
      Rails.logger.tagged("[Step Completed]") { Rails.logger.info "Step #{step.id} for #{user.id} completed." } unless Rails.env.production?
      completed = StepCompleted.find_or_initialize_by(quest_id: step.quest_id, step_id: completion.step_id, person_id: user.id)
      completed.status = StepCompleted.statuses[:completed]
      if completed.valid?
        self.step_completed(user, completed)
        completed.save
        if step.step_unlocks.present?
          Rails.logger.tagged("[Completion Created]") { Rails.logger.info "Step has unlocks. Generating completed statuses for unlocks" } unless Rails.env.production?
          step.step_unlocks.each do |unlock|
            unlocked = StepCompleted.find_or_initialize_by(quest_id: step.quest_id, step_id: unlock.unlock.id, person_id: user.id)
            unlocked.status = StepCompleted.statuses[:unlocked]
            if unlocked.valid?
              unlocked.save
              Rails.logger.tagged("[Completion Created]") { Rails.logger.info "Step: #{unlocked.step.id} created with ID #{unlocked.id} for User: #{user.id}" } unless Rails.env.production?
              # unlock.step.touch
              # unlock.step.quest.touch
            else
              Rails.logger.tagged("[Completion Created]") { Rails.logger.error "Step: #{unlock.step.id} failed to save for User: #{user.id}" } unless Rails.env.production?
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

  def self.create_step_successful(step)
    Rails.logger.tagged("Step Created Listener") { Rails.logger.info "New step created with Step: #{step.id} with Unlocks: #{step.unlocks}" } unless Rails.env.production?
    if step.unlocks.present?
      StepUnlock.create(step_id: step.unlocks, unlock_id: step.uuid)
    end
  end

  def self.update_step_successful(step)
    if step&.unlocks != nil
      su = StepUnlock.find_or_initialize_by(unlock_id: step.uuid)
      su.step_id = step.unlocks
      if su.save
        Rails.logger.tagged("Step Updated Listener") { Rails.logger.info "Updated unlock for Step: #{step.id} UUID: #{step.uuid} to be unlocked by #{step.unlocks}" } unless Rails.env.production?
      else
        Rails.logger.tagged("Step Updated Listener") { Rails.logger.error "Failed to update previous unlock for Step: #{step.id} UUID: #{step.uuid} to be unlocked by #{step.unlocks}" } unless Rails.env.production?
        puts su.inspect
      end
    else
      if StepUnlock.exists?(unlock_id: step.uuid)
        StepUnlock.find_by(unlock_id: step.uuid).delete
        Rails.logger.tagged("Step Updated Listener") { Rails.logger.error "Deleting unlock for Step: #{step.id}" } unless Rails.env.production?
      end
    end
  end
end
