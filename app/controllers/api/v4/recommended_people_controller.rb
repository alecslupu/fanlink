# frozen_string_literal: true

class Api::V4::RecommendedPeopleController < Api::V3::RecommendedPeopleController
  def index
    @people = Person.where(recommended: true).where.not(id: current_user)
    return_the @people, handler: tpl_handler
  end

  protected

    def tpl_handler
      :jb
    end
end
