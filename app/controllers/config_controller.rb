# frozen_string_literal: true
class ConfigController < ApplicationController
  include JSONErrors

  skip_before_action :require_login, only: %i[show index]

  def show
    @product = Product.enabled.where(internal_name: params[:internal_name]).first!
    @root = @product.config_items.enabled.roots.where(item_key: "json_version", item_value: params[:id].to_i).first!
    return_the @root, handler: :jb
  end

  def index
    @product = Product.enabled.where(internal_name: params[:internal_name]).first!
    @root = @product.config_items.enabled.roots.last
    return_the @root, handler: :jb
  end
end
