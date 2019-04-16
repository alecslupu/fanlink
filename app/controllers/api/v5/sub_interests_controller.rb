class Api::V5::SubInterestsController < Api::V4::SubInterestsController
  def index
    @sub_interests = SubInterast.all
    return_the @sub_interests, handler: tpl_handler
  end
end
