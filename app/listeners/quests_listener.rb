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
    total_steps = Quest.find(step.id).steps.count
    completed_steps = StepCompleted.where(quest_id: step.id, person_id: user.id).count
    if total_steps == completed_steps
      completed = QuestCompleted.find_or_initialize_by(person_id: user.id, quest_id: step.quest_id)
      if completed.valid?
        completed.save
      end
    end
  end
end
