class Api::V1::BadgesController < ApiController

  #**
  # @api {get} /badges Get badges.
  # @apiName GetBadges
  # @apiGroup Badges
  #
  # @apiDescription
  #   This gets a list of badges that can be earned by the current user.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "pending_badges": [
  #       {
  #         ""....message json..see get message action ....
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  #*

end
