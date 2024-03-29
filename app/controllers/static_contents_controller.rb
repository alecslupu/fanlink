# frozen_string_literal: true

class StaticContentsController < ApplicationController
  before_action :set_static_content, only: %i[show]

  def show
  end

  private

  def set_static_content
    @static_content = Static::WebContent.where(slug: params[:slug], product_id: params[:product_id]).first!
  end
end
