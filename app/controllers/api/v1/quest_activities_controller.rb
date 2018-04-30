class Api::V1::QuestActivitiesController < ApiController
    load_up_the Quest, from: :quest_id, except: %i[ update ]
    load_up_the QuestActivity, only: %i[ update ]

    def create
        @quest_activity = @quest.quest_activities.create(activity_params)
        return_the @quest_activity
    end

    def update
        @quest_activity.update_attributes(activity_params)
        return_the @quest_activity
    end

private
    def activity_params
        params.require(:quest_activity).permit( :description, :hint, :post, :image, :audio, :requires)
    end
end