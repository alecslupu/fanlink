class Api::V3::BadgesDoc < Api::V3::BaseDoc
  doc_tag name: "Badges", desc: "Badges"
  route_base "api/v3/badges"
  components do
    resp BadgesArray: ["HTTP/1.1 200 Ok", :json, data: {
      badges: [
          badge: :BadgeJson
      ]
    }]

    resp BadgesObject: ["HTTP/1.1 200 Ok", :json, data: {
      badge: :BadgeJson
    }]

    body! :BadgeCreateForm, :form, data: {
      badge!: {
        name!: { type: String, desc: "Display friendly name for the badge. Translatable" },
        internal_name!: { type: String, desc: "Internal name of the badge" },
        description!: { type: String, desc: "A short paragraph describing the badge. Translatable." },
        picture: { type: File, desc: "Image associated with the badge." },
        issued_from: { type: String, format: "date-time", desc: "Start time for when the badge is available to earn." },
        issued_to: { type: String, format: "date-time", desc: "End time for when the badge is available to earn." }
      }
    }

    body! :BadgeUpdateForm, :form, data: {
      badge!: {
        name!: { type: String, desc: "Display friendly name for the badge. Translatable" },
        internal_name!: { type: String, desc: "Internal name of the badge" },
        description!: { type: String, desc: "A short paragraph describing the badge. Translatable." },
        picture: { type: File, desc: "Image associated with the badge." },
        issued_from: { type: String, format: "date-time", desc: "Start time for when the badge is available to earn." },
        issued_to: { type: String, format: "date-time", desc: "End time for when the badge is available to earn." }
      }
    }
  end
  api :index, "Get badges" do
    need_auth :SessionCookie
    query :person_id, Integer, desc: "The id of the person whose badges you want."
    path :person_id, Integer, desc: "The id of the person whose badges you want."
    response_ref 200 => :BadgesArray
  end

  api :create, "Create a badge" do
    need_auth :SessionCookie
    desc "Creates a new badge."
    body_ref :BadgeCreateForm
    response_ref 200 => :BadgesObject
  end

  api :show, "Find a badge" do
    need_auth :SessionCookie
    desc "Finds a badge for the provided id."
    response_ref 200 => :BadgesObject
  end

  api :update, "Update a badge" do
    need_auth :SessionCookie
    desc "Updates a badge for the provided id."
    body_ref :BadgeUpdateForm
    response_ref 200 => :BadgesObject
  end

  # api :destroy, "Destroy a badge" do
  #   need_auth :SessionCookie
  #   desc "Soft deletes a badge."
  #   response_ref 200 => :OK
  # end
end
