#**
# @api {get} /rooms/{room_id}/messages Get messages.
# @apiName GetMessages
# @apiGroup Messages
# @apiVersion 1.0.0
#
# @apiDescription
#   This gets a list of message for a from date, to date, with an optional
#   limit. Messages are returned newest first, and the limit is applied to that ordering.
#
# @apiParam {String} from_date
#   From date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
#
# @apiParam {String} to_date
#   To date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
#
# @apiParam {Integer} [limit]
#   Limit results to count of limit.
#
# @apiSuccessExample {json} Success-Response:
#     HTTP/1.1 200 Ok
#     "messages": [
#       { ....message json..see get message action ....
#       },....
#     ]
#
# @apiErrorExample {json} Error-Response:
#     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
#*
