# frozen_string_literal: true
class Api::V3::RecommendedPeopleController < Api::V2::RecommendedPeopleController
  # **
  # @api {get} /people/recommended Get recommended people.
  # @apiName GetRecommendedPeople
  # @apiGroup People
  # @apiVersion 1.0.0
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
  # *

  def index
    @people = Person.where(recommended: true).where.not(id: current_user).where.not(id: current_user.following)
    return_the @people
  end
end
