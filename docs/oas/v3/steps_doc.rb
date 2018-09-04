class Api::V3::StepsDoc < Api::V3::BaseDoc
  doc_tag name: "Steps", desc: "Steps for a quest"
  route_base "api/v3/steps"
  components do
    resp StepObject: ["HTTP/1.1 200 Ok", :json, data: {
      step: :StepJson
    }]

    resp Array: ["HTTP/1.1 200 Ok", :json, data: {
      steps: [
        step: :StepJson
      ]
    }]

    body! :StepCreateForm, :form, data: {
      step!: {
        unlocks: { type: String, desc: "The previous step that is unlocks this step." },
        display: { type: String, desc: "Sets the display name for the step." }
      }
    }

    body! :StepUpdateForm, :form, data: {
      step!: {
        unlocks: { type: String, desc: "The previous step that unlocks this step." },
        display: { type: String, desc: "Sets the display name for the step." }
      }
    }
  end

  api :index, "Get all steps" do
    need_auth :SessionCookie
    desc "Returns all the steps for a quest"
    path! :quest_id, Integer, desc: "The ID of the quest to fetch steps for."
    response_ref 200 => :Array
  end

  api :create, "Create a step" do
    need_auth :SessionCookie
    desc "Creates a step for the supplied quest id."
    path! :quest_id, Integer, desc: "The ID of the quest to fetch steps for."
    body_ref :StepCreateForm
    response_ref 200 => :StepObject
  end

  api :show, "Find a step" do
    need_auth :SessionCookie
    desc "Returns the step for the supplied id."
    response_ref 200 => :StepObject
  end

  api :update, "Update a step" do
    need_auth :SessionCookie
    desc "Updates a step for the supplied id."
    body_ref :StepUpdateForm
    response_ref 200 => :StepObject
  end

  api :destroy, "Destroy a step" do
    need_auth :SessionCookie
    desc "Soft deletes a step."
    response_ref 200 => :OK
  end
end
