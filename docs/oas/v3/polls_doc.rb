class Api::V3::PollsDoc < Api::V3::BaseDoc
  doc_tag name: "Polls", desc: "User/product polls"
  route_base "api/v3/polls"

  components do
    resp PollsArray: ["HTTP/1.1 200 Ok", :json, data: {
      polls: [
        poll: :PollJson
      ]
    }]
    resp PollsListsArray: ["HTTP/1.1 200 Ok", :json, data: {
      polls: [
        poll: :PollListJson
      ]
    }]
    resp PollsObject: ["HTTP/1.1 200 Ok", :json, data: {
      poll: :PollJson
    }]
    resp PollsShareObject: ["HTTP/1.1 200 Ok", :json, data: {
      poll: :PollShareJson
    }]

    body! :PollCreateForm, :form, data: {
      poll!: {
        description: {type: String, desc: "The description of the poll"},
        start_date: {type: String, format: "date-time", desc: "When the pool should start"},
        duration: {type: String, desc: "The amount of time the poll should last"},
        pool_status: {type: String, desc: "Valid values: 'active', 'disabled'"},
      }
    }

    body! :PollUpdateForm, :form, data: {
      poll!: {
        description: {type: String, desc: "The description of the poll"},
        start_date: {type: String, format: "date-time", desc: "When the pool should start"},
        duration: {type: String, desc: "The amount of time the poll should last"},
        pool_status: {type: String, desc: "Valid values: 'active', 'disabled'"},
      }
    }
  end

  api :create, "Create a poll." do
    need_auth :SessionCookie
    desc "This creates a poll and attaches it to a Post"
    body_ref :PollCreateForm
    response_ref 200 => :PollsObject
  end

  api :show, "Get a single poll." do
    need_auth :SessionCookie
    desc "This gets a single poll for a poll id."
    response_ref 200 => :PollsObject
  end

  api :update, "Update a poll" do
    need_auth :SessionCookie
    desc "This updates a poll."
    body_ref :PollUpdateForm
    response_ref 200 => :PollsObject
  end

  api :destroy, "Delete (hide) a single poll." do
    need_auth :SessionCookie
    desc "This deletes a single poll by marking as deleted. Can only be called by the creator."
    response_ref 200 => :OK
  end
end
