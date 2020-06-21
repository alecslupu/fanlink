# frozen_string_literal: true

class Api::V3::InterestsController < ApiController
  load_up_the Interest, from: :id, only: %i[update delete add_interest]

  # **
  #
  # @api {get} /interests Get Interests
  # @apiName GetInterests
  # @apiGroup Interests
  # @apiVersion  3.0.0
  #
  #
  # @apiSuccess (200) {Object} Interests lists
  #
  # @apiParamExample  {type} Request-Example:
  # {
  #     property : value
  # }
  #
  #
  # @apiSuccessExample {type} Success-Response:
  # {
  #     property : value
  # }
  #
  #
  # *
  def index
    @interests = Interest.interests(ActsAsTenant.current_tenant).order(order: :desc)
    return_the @interests
  end

  def create
    if some_admin?
      @interest = Interest.create(interest_params)
      if @interest.valid?
        return_the @interest
      else
        render_422 @interest.errors
      end
    else
      render_not_found
    end
  end

  def update
    if params.has_key?(:interest)
      if some_admin?
        if @interest.update(interest_params)
          return_the @interest
        else
          render_422 @interest.errors
        end
      else
        render_not_found
      end
    else
      return_the @interest
    end
  end

  def destroy
    if some_admin?
      @interest.destroy
      head :ok
    else
      render_not_found
    end
  end

  def add_interest
    if @interest.parent_id.present? && current_user.interests.exists?(@interest.parent_id)
      current_user.interests.delete(@interest.parent_id)
    end
    if @interest.parent_id.nil?
      current_user.interests.delete(Interest.where(parent_id: @interest.id))
    end
    current_user.interests << @interest
    head :ok
  end

  def remove_interest
    current_user.interests.delete(@interest)
    head :ok
  end

  private
    def interest_params
      params.require(:interest).permit(:title, :parent_id, :order)
    end
end
