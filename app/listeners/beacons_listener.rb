class BeaconsListener
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
                completed.save
                puts "Step Completed Created."
                puts "#{completed.inspect}"
                if step.unlocks.present?
                    puts "Step has unlocks. Generating completed statuses for unlocks"
                    step.unlocks.each do |unlock|
                        unlocked = StepCompleted.create({quest_id: step.quest_id, step_id: unlock, person_id: user.id, status: StepCompleted.statuses[:unlocked]})
                        puts "#{unlocked.inspect}"
                    end
                end
            end
        end
    end
end
