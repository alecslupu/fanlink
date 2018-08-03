class Api::V3::Docs::AssignedRewardsDoc < Api::V3::Docs::BaseDoc
  doc_tag name: "AssignedRewards", desc: "This allows admins to assign rewards to other systems. Currently supports ActionType, Quest, Step, and QuestActivity."
  route_base "api/v3/assigned_rewards"
  components do
    resp AssignedRewardObject: ["HTTP/1.1 200 Ok", :json, data: {
      assigned: :AssignedRewardJson
    }]

    resp AssignedRewardArray: ["HTTP/1.1 200 Ok", :json, data: {
      assignees: [
        assigned: :AssignedRewardJson
      ]

    }]

    body! :AssignedRewardCreateForm, :form, data: {
      assign!: {
        reward_id!: { type: Integer, desc: "The ID of the reward it is being assigned to." },
        assigned_type!: { type: String, desc: "The model name that the reward belongs to." },
        assigned_id!: { type: Integer, desc: "The id of the type that is being assigned. Example: If you want to assign the quest with an ID of 1, you would set the type to Quest and the id to 1." },
        max_times: { type: Integer, desc: "The maximum number of times the assigned item can be completed for credit.", dft: 1 }
      }
    }

    body! :AssignedRewardUpdateForm, :form, data: {
      assign!: {
        max_times: { type: Integer, desc: "The maximum number of times the assigned item can be completed for credit.", dft: 1 }
      }
    }
  end

  api :index, "Return all assigned rewards" do
    need_auth :SessionCookie
    desc "Returns all assigned rewards for the provided reward id."
    response_ref 200 => :AssignedRewardArray
  end

  api :create, "Create an assigned reward" do
    need_auth :SessionCookie
    desc "Links a model with a reward."
    body_ref :AssignedRewardCreateForm
    response_ref 200 => :AssignedRewardObject
  end

  # api :show, "Find an assigned reward" do
  #   need_auth :SessionCookie
  #   desc "Returns the assigned reward for the provided id."
  #   response_ref 200 => :AssignedRewardObject
  # end

  api :update, "Update an assigned reward" do
    need_auth :SessionCookie
    desc "Allows you to update the max_times field."
    body_ref :AssignedRewardUpdateForm
    response_ref 200 => :AssignedRewardObject
  end

  api :destroy, "Destroy an assigned reward." do
    need_auth :SessionCookie
    desc "Soft deletes an assigned reward."
    response_ref 200 => :OK
  end
end
