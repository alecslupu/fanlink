class Api::V1::NotificationDeviceIdsController < ApiController
  #**
  # @api {post} /notification_device_ids Add a new device id for a person.
  # @apiName CreateNotificationDeviceId
  # @apiGroup People
  #
  # @apiDescription
  #   This adds a new device id to be used for notifications to the Firebase Cloud Messaging Service. A user can have
  #   any number of device ids.
  #
  # @apiParam {String} device_id
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Device ID already registered" }
  #*
  def create
    if params[:device_id].present?
      ndi = current_user.notification_device_ids.create(device_identifier: params[:device_id])
      if ndi.valid?
        head :ok
      else
        render_error(ndi.errors.full_messages)
      end
    else
      render_error("Missing device_id")
    end
  end

  #**
  # @api {delete} /notification_device_ids Delete a device id
  # @apiName DeleteNotificationDeviceId
  # @apiGroup People
  #
  # @apiDescription
  #   This deletes a single device id. Can only be called by the owner.
  #
  # @apiParam {String} device_id
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #*
  def destroy
    if params[:device_id].present?
      ndi = NotificationDeviceId.find_by(person_id: current_user.id, device_identifier: params[:device_id])
      if ndi
        ndi.destroy
        head :ok
        return
      end
    end
    head :not_found
  end
end
