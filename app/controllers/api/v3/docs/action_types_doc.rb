class Api::V3::Docs::ActionTypesDoc < Api::V3::Docs::BaseDoc
  doc_tag name: "ActionTypes", desc: "Action types allow the apps to send actions that count towards badge/reward unlocks.(Super Admin Only)"
  route_base "api/v3/action_types"
  components do
    resp ActionTypeObject: ["HTTP/1.1 200 Ok", :json, data: {
      action: :ActionTypeJson
    }]

    resp ActionTypeArray: ["HTTP/1.1 200 Ok", :json, data: {
      actions: [
        Action: :ActionTypeJson
      ]
    }]

    body! :ActionTypeCreateForm, :form, data: {
      action_type!: {
        name!: { type: String, desc: "Display friendly name of the action type." },
        internal_name!: { type: String, desc: "Internal name of the action type." },
        seconds_lag: { type: Integer, desc: "Delay between each action before it will count towards progression.", dt: 0 },
        active: { type: Boolean, desc: "Determines if the action is actively being used in the apps." }
      }
    }

    body! :ActionTypeUpdateForm, :form, data: {
      action_type!: {
        name: { type: String, desc: "Display friendly name of the action type." },
        internal_name: { type: String, desc: "Internal name of the action type." },
        seconds_lag: { type: Integer, desc: "Delay between each action before it will count towards progression.", dt: 0 },
        active: { type: Boolean, desc: "Determines if the action is actively being used in the apps." }
      }
    }
  end

  api :index, "Get all action types" do
    need_auth :SessionCookie
    desc "Returns all action types."
    response_ref 200 => :ActionTypeArray
  end

  api :create, "Create an action type" do
    need_auth :SessionCookie
    desc "This creates an action type. Action types do nothing until implimented within the apps."
    body_ref :ActionTypeCreateForm
    response_ref 200 => :ActionTypeObject
  end

  api :show, "Find an action type" do
    need_auth :SessionCookie
    desc "Returns the action type for the given id."
    response_ref 200 => :ActionTypeObject
  end

  api :update, "Update an action type." do
    need_auth :SessionCookie
    desc "This updates an action type."
    body_ref :ActionTypeUpdateForm
    response_ref 200 => :ActionTypeObject
  end

  api :destroy, "Destroy an action type" do
    need_auth :SessionCookie
    desc "This destroys an action type. If the action type is in use, it will not be allowed to be destroyed."
    response_ref 200 => :OK
  end
end
