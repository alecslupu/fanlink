class QuestCompleted
    include RealTimeHelpers
    def addpoints(user, quest)

    end

    def StepCompleted(user, step)
        QuestCompleted.create()
    end
end