class Api::V5::MerchandiseController < Api::V4::MerchandiseController
  def index
    @merchandise = paginate(Merchandise.listable.order(:priority))
    return_the @merchandise, handler: tpl_handler
  end

  def show
    @merchandise = Merchandise.listable.find(params[:id])
    return_the @merchandise, handler: tpl_handler
  end
end
