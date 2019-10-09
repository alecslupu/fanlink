class ConfigController < ApplicationController
  skip_before_action :require_login, only: %i[ show ]

  def show
    @product = Product.enabled.where(internal_name: params[:internal_name]).first!
    return_the @product, handler: :jb
  end
end
