class Api::V1::Docs::NotificationDeviceIdsDoc < Api::V1::Docs::BaseDoc
  #**
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
  #*

  #**
  # @api {delete} /notification_device_ids Delete a device id
  # @apiName DeleteNotificationDeviceId
  # @apiGroup People
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This deletes a single device id. Can only be called by the owner.
  #
  # @apiParam (body) {String} device_id
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #*
  doc_tag name: 'NotificationDeviceIds', desc: "Notification Device IDs"
  route_base 'api/v1/notification_device_ids'
end
