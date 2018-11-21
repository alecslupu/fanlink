class Api::V4::MerchandiseController < Api::V3::MerchandiseController
  def index
    @merchandise = paginate(Merchandise.listable.order(:priority))
    return_the @merchandise, handler: 'jb'
  end

  def show
    @merchandise = Merchandise.listable.find(params[:id])
    return_the @merchandise, handler: 'jb'
  end

  def create
    @merchandise = Merchandise.create(merchandise_params)
    if @merchandise.valid?
      broadcast(:merchandise_created, current_user, @merchandise)
      return_the @merchandise, handler: 'jb', using: :show
    else
      render_422 @merchandise.errors
    end
  end

  def update
    if params.has_key?(:merchandise)
      if @merchandise.update_attributes(merchandise_params)
        broadcast(:merchandise_updated, current_user, @merchandise)
        return_the @merchandise, handler: 'jb', using: :show
      else
        render_422 @merchandise.errors
      end
    else
      return_the @merchandise, handler: 'jb', using: :show
    end
  end
end
