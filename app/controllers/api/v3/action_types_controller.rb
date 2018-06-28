class Api::V3::ActionTypesController < Api::V3::BaseController
  include Rails::Pagination
  include Wisper::Publisher
  def index
    @action_types = ActionType.all
    return_the @action_types
  end

  def show

  end

  def create

  end

  def update

  end

  def destroy

  end

private
end
