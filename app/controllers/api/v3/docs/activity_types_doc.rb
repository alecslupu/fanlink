class Api::V3::Docs::ActivtyTypesDoc < Api::V3::Docs::BaseDoc
  doc_tag name: "ActivityTypes", desc: "Activity Types"
  route_base "api/v3/activity_types"
  components do
    resp ActivityTypeObject: ["HTTP/1.1 200 Ok", :json, data: {
      type: :ActivityTypeJson
    }]
    resp ActivityTypeArray: ["HTTP/1.1 200 Ok", :json, data: {
      types: [
        type: :ActivityTypeJson
      ]
    }]
    body! :TypeBodyCreate, :form, data: {
      activity_type!: {
        atype!: { type: String, desc: "Activity Type. Valid types are beacon, post, image, audio, activity_code." },
        value!: {
          id: { type: String, desc: "This field is used as an identifier for determining completion criteria of the atype. ID for Product Beacons, Unlock code for activity code, hashtag for post." },
          description: { type: String, desc: "This field is used as a display field for the end user." }
        }
      }
    }
    body! :TypeBodyUpdate, :form, data: {
      activity_type!: {
        atype: { type: String, desc: "Activity Type. Valid types are beacon, post, image, audio, activity_code." },
        value: {
          id: { type: String, desc: "This field is used as an identifier for determining completion criteria of the atype. ID for Product Beacons, Unlock code for activity code, hashtag for post." },
          description: { type: String, desc: "This field is used as a display field for the end user." }
        }
      }
    }
  end

  api :index, "Get Activity types" do
    need_auth :SessionCookie
    desc "Get the activity types belonging to the activity. Returns them ordered by created at descending."
    path! :activity_id, Integer, desc: "Activity ID"
    response_ref 200 => :ActivityTypeArray
  end

  api :create, "Create Type for Activity" do
    need_auth :SessionCookie
    desc "Creates an activity type to be used with the quest activity."
    path! :activity_id, Integer, desc: "Quest Activity ID"
    body_ref :TypeBodyCreate
    response_ref 200 => :ActivityTypeObject
  end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :show, "Get an activity type" do
    need_auth :SessionCookie
    desc "Gets activity type by ID"
    response_ref 200 => :ActivityTypeObject
  end

  api :update, "Update a type" do
    need_auth :SessionCookie
    desc "Updates an activity type"
    body_ref :TypeBodyUpdate
    response_ref 200 => :ActivityTypeObject
  end

  api :destroy, "Delete a type from an activity" do
    need_auth :SessionCookie
    desc "Deletes the activity type for given ID, removing it from the Quest Activities."
    response_ref 200 => :OK
  end
end
