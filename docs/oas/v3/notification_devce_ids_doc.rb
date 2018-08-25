class Api::V3::NotificationDeviceIdsDoc < Api::V3::BaseDoc
  doc_tag name: "NotificationDeviceIds", desc: "Notification Device IDs"
  route_base "api/v3/notification_device_ids"
  components do
    body! :NotificationDeviceIdsForm, :form, data: {
      device_id!: { type: String, desc: "ID of the device" }
    }
  end

  # api :index, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :create, "Add a new device id for a person." do
    need_auth :SessionCookie
    desc "This adds a new device id to be used for notifications to the Firebase Cloud Messaging Service. A user can have any number of device ids."
    body_ref :NotificationDeviceIdsForm
    response_ref 200 => :OK
  end

  api :destroy, "Delete a device id" do
    desc "This deletes a single device id. Can only be called by the owner."
    response_ref 200 => :OK
  end
end
