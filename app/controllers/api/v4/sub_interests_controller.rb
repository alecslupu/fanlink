class Api::V4::SubInterestsController < Api::V3::SubInterestsController
  def index
    @sub_interests = SubInterast.all
    return_the @sub_interests, handler: 'jb'
  end
end
