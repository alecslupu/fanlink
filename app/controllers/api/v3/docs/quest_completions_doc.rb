class Api::V3::Docs::ActivtyTypesDoc < Api::V3::Docs::BaseDoc
  doc_tag name: "QuestCompletions", desc: "This is used to register an activity as completed."
  route_base "api/v3/quest_completions"
  components do
    resp QuestCompletionObject: ["HTTP/1.1 200 Ok", :json, data: {
      completion: :QuestCompletionJson
    }]

    resp QuestCompletionArray: ["HTTP/1.1 200 Ok", :json, data: {
      completions: [
        completion: :QuestCompletionJson
      ]
    }]

    body! :QuestCompletionCreateForm, :form, data: {
      quest_completion!: {
        activity_id!: { type: Integer, desc: "The id of the activity completed." }
      }
    }

    body! :QuestCompletionUpdateForm, :form, data: {
      quest_completion!: {
        activity_id!: { type: Integer, desc: "The id of the activity completed." }
      }
    }
  end

  api :index, "Get all activity completions for the current user." do
    need_auth :SessionCookie
    desc "Returns all quest completions for the currently logged in user."
    response_ref 200 => :QuestCompletionArray
  end

  api :create, "Create a quest completion" do
    need_auth :SessionCookie
    desc "This registers an activity as complete for the current user."
    path! :step_id, Integer, desc: "The step the activity is associated with."
    body_ref :QuestCompletionObject
    response_ref 200 => :QuestCompletionObject
  end

  api :show, "Find a quest completion" do
    need_auth :SessionCookie
    desc "Returns the quest completion for the provided id."
    response_ref 200 => :QuestCompletionObject
  end

  api :update, "Update a quest completion" do
    need_auth :SessionCookie
    desc "Updates a completion."
    body_ref :QuestCompletionUpdateForm
    response_ref 200 => :QuestCompletionObject
  end

  api :destroy, "Destroy a " do
    need_auth :SessionCookie
    desc "Soft deletes a completion"
    response_ref 200 => :OK
  end
end
