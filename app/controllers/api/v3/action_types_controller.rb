class Api::V3::ActionTypesController < ApiController
  include Wisper::Publisher
  include Rails::Pagination
  include Swagger::Blocks
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
