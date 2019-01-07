class Api::V5::RecommendedPeopleController < Api::V4::RecommendedPeopleController
  def index
    @people = Person.where(recommended: true).where.not(id: current_user).where.not(id: current_user.following)
    return_the @people, handler: 'jb'
  end
end
