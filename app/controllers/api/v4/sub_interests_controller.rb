# frozen_string_literal: true

class Api::V4::SubInterestsController < Api::V3::SubInterestsController
  def index
    @sub_interests = SubInterast.all
    return_the @sub_interests, handler: tpl_handler
  end

  protected

    def tpl_handler
      :jb
    end
end
