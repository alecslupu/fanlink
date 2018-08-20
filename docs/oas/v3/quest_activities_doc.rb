class Api::V3::QuestActivitiesDoc < Api::V3::BaseDoc
  doc_tag name: "QuestActivities", desc: "Quest Activities"
  route_base "api/v3/quest_activities"
  components do
    resp QuestActivityObject: ["HTTP/1.1 200 Ok", :json, data: {
      activity: :QuestActivityJson
    }]

    resp QuestActivityArray: ["HTTP/1.1 200 Ok", :json, data: {
      activities: [
        activity: :QuestActivityJson
      ]
    }]

    body! :QuestActivityCreateForm, :form, data: {
      quest_activity!: {
        #:name => { type: Object, desc: 'Name of the activity. Translatable' },
        description: { type: Object, desc: "Description of the activity. Translatable" },
        hint!: { type: Object, desc: "A hint for completing the quest activity. Translatable." },
        picture: { type: File, desc: "An image associated with the quest activity." }
      }
    }

    body! :QuestActivityUpdateForm, :form, data: {
      quest_activity!: {
        #:name => { type: Object, desc: 'Name of the activity. Translatable' },
        description: { type: Object, desc: "Description of the activity. Translatable" },
        hint: { type: Object, desc: "A hint for completing the quest activity. Translatable." },
        picture: { type: File, desc: "An image associated with the quest activity." }
      }
    }
  end

  api :index, "Get Quest Activities" do
    need_auth :SessionCookie
    path! :step_id, Integer, desc: "The step id of the quest activities you are wanting to retrieve."
    desc "Get all quest activities associated with a step."
    response_ref 200 => :QuestActivityArray
  end

  api :create, "Create a quest activity" do
    need_auth :SessionCookie
    desc "Creates a quest activity"
    body_ref :QuestActivityCreateForm
    response_ref 200 => :QuestActivityObject
  end

  api :show, "Find a quest activity" do
    need_auth :SessionCookie
    desc "Returns the quest activity associated with the id."
    response_ref 200 => :QuestActivityObject
  end

  api :update, "Update a quest activity" do
    need_auth :SessionCookie
    desc "Updates a quest activity associated with the id."
    body_ref :QuestActivityUpdateForm
    response_ref 200 => :QuestActivityObject
  end

  api :destroy, "Delete a quest activity." do
    need_auth :SessionCookie
    desc "Soft deletes a quest activity."
    response_ref 200 => :OK
  end
end
