class Api::V3::RewardsDoc < Api::V3::BaseDoc
  doc_tag name: "Rewards", desc: "Reward system. Handles linking rewards to various things."
  route_base "api/v3/rewards"
  components do
    resp RewardObject: ["HTTP/1.1 200 Ok", :json, data: {
      reward: :RewardJson
    }]

    resp RewardArray: ["HTTP/1.1 200 Ok", :json, data: {
      rewards: [
        reward: :RewardJson
      ]
    }]

    body! :RewardCreateForm, :form, data: {
      reward!: {
        name!: { type: String, desc: "Display friendly name of the reward." },
        internal_name!: { type: String, desc: "Internal name of the reward." },
        reward_type!: { type: String, desc: "What the reward provides. Currently supports badges." },
        reward_type_id!: { type: Integer, desc: "The ID of the reward_type. Example: If this reward gives a badge, you would set the type to Badge and the ID to the ID of the badge it should reward." },
        series: { type: String, desc: "The series this reward belongs to. For rewards that are awarded from actions, this is the action type internal name. For all others, it's up to the person creating the reward." },
        completion_requirement: { type: Integer, desc: "The number of completions required to unlock this reward." },
        points: { type: String, desc: "The amount of points this reward gives towards a person's level." },
        status: { type: String, desc: "The status of the reward. Can be active or inactive." }
      }
    }

    body! :RewardUpdateForm, :form, data: {
      reward!: {
        name!: { type: String, desc: "Display friendly name of the reward." },
        internal_name!: { type: String, desc: "Internal name of the reward." },
        reward_type!: { type: String, desc: "What the reward provides. Currently supports badges." },
        reward_type_id!: { type: Integer, desc: "The ID of the reward_type. Example: If this reward gives a badge, you would set the type to Badge and the ID to the ID of the badge it should reward." },
        series: { type: String, desc: "The series this reward belongs to. For rewards that are awarded from actions, this is the action type internal name. For all others, it's up to the person creating the reward." },
        completion_requirement: { type: Integer, desc: "The number of completions required to unlock this reward." },
        points: { type: String, desc: "The amount of points this reward gives towards a person's level." },
        status: { type: String, desc: "The status of the reward. Can be active or inactive." }
      }
    }
  end

  api :index, "Get all rewards" do
    need_auth :SessionCookie
    desc "Returns all rewards for the current user's product"
    response_ref 200 => :RewardArray
  end

  api :create, "Create a reward" do
    need_auth :SessionCookie
    desc "Creates a reward"
    body_ref :RewardCreateForm
    response_ref 200 => :RewardObject
  end

  api :show, "Find a reward" do
    need_auth :SessionCookie
    desc "Returns the reward for the provided id."
    response_ref 200 => :RewardObject
  end

  api :update, "Update a reward" do
    need_auth :SessionCookie
    desc "Updates a reward"
    body_ref :RewardUpdateForm
    response_ref 200 => :RewardObject
  end

  api :destroy, "Destroy a reward" do
    need_auth :SessionCookie
    desc "Soft deletes a reward"
    response_ref 200 => :OK
  end
end
