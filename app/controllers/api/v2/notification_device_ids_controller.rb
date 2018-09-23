class Api::V2::NotificationDeviceIdsController < Api::V1::NotificationDeviceIdsController
  # **
  # @api {post} /notification_device_ids Add a new device id for a person.
  # @apiName CreateNotificationDeviceId
  # @apiGroup People
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This adds a new device id to be used for notifications to the Firebase Cloud Messaging Service. A user can have
  #   any number of device ids.
  #
  # @apiParam (body) {String} device_id
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Device ID already registered" }
  # *

  def create
    if params[:device_id].present?
      NotificationDeviceId.find_by(device_identifier: params[:device_id]).destroy if NotificationDeviceId.where(device_identifier: params[:device_id]).exists?
      ndi = current_user.notification_device_ids.create(device_identifier: params[:device_id])
      if ndi.valid?
        head :ok
      else
        render_error(ndi.errors)
      end
    else
      render_error("Missing device_id")
    end
  end

end
