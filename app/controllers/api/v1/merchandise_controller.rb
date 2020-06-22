# frozen_string_literal: true

class Api::V1::MerchandiseController < ApiController
  def index
    @merchandise = Merchandise.listable.order(:priority)
  end

  def show
    @merchandise = Merchandise.listable.find(params[:id])
    return_the @merchandise
  end
end
