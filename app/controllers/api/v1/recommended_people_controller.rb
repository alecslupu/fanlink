class Api::V1::RecommendedPeopleController < ApiController
  #**
  # @api {get} /people/recommended Get recommended people.
  # @apiName GetRecommendedPeople
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to get a list of people flagged as 'recommended'. It excludes the current user and anyone
  #   the current user is following.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #   "recommended_people" {
  #     [ ... person json ...],
  #     ....
  #   }
  #*
  def index
    @people = Person.where(recommended: true).where.not(id: current_user).where.not(id: current_user.following)
    return_the @people
  end
end
