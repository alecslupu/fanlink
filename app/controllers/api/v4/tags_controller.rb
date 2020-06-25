# frozen_string_literal: true

module Api
  module V4
    class TagsController < Api::V3::TagsController
      def index
        if params[:tag_name].present?
          @posts = paginate Post.for_product(ActsAsTenant.current_tenant).visible.tagged_with(params[:tag_name].try(:downcase), match_all: true)
          return_the @posts, handler: tpl_handler
        elsif some_admin? && web_request?
          @tags = paginate ActsAsTaggableOn::Tag.all
          return_the @tags, handler: tpl_handler
        else
          render_422 _('Parameter tag_name is required.')
        end
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
