# frozen_string_literal: true
class StaticContentsController < ApplicationController
  before_action :set_static_content, only: %i[show]

  def show
  end

  private

  def set_static_content
    @static_content = StaticContent.find_by(slug: params[:slug], product_id: params[:product_id])
  end
end
