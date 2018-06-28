class Api::V1::Docs::LevelsDoc < Api::V1::Docs::BaseDoc
  #**
  # @api {get} /levels Get all available levels.
  # @apiName GetLevels
  # @apiGroup Level
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of all levels available to be obtained.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "levels": [
  #       {
  #         "id": "123"
  #         "name": "Level One",
  #         "internal_name": "level_one",
  #         "description": "some level translated to current language",
  #         "points": 10,
  #         "picture_url": "http://example.com/images/14"
  #       },...
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  #*

end
