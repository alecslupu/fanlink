# frozen_string_literal: true
module Api
  module V1
    class PostsController < ApiController
      # TODO remove this class
      before_action :load_post, only: %i[update]
      before_action :admin_only, only: %i[list]
      skip_before_action :require_login, :set_product, only: %i[share]
    end
  end
end
