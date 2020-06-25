# frozen_string_literal: true

module Api
  module V3
    class TagsController < Api::V2::TagsController
      # **
      #
      # @api {get} /posts/tags/:tag_name Get Posts by Tag Name
      # @apiName GetPostsByTagName
      # @apiGroup Tags
      # @apiVersion  2.0.0
      #
      #
      # @apiParam  {String} tag_name The tag to return posts for
      #
      # @apiSuccess (200) {Object} Posts description
      #
      # @apiParamExample  {type} Request-Example:
      # {
      #     property : value
      # }
      #
      #
      # @apiSuccessExample {type} Success-Response:
      # {
      #     property : value
      # }
      #
      #
      # *
      def index
        if params[:tag_name].present?
          @posts = Post.for_product(ActsAsTenant.current_tenant).visible
                     .tagged_with(params[:tag_name].try(:downcase), match_all: true)
          return_the @posts
        else
          render_422 _('Parameter tag_name is required.')
        end
      end
    end
  end
end
