# frozen_string_literal: true


module Api
  module V4
    class PostCommentReportsController < Api::V3::PostCommentReportsController
      def index
        @post_comment_reports = paginate apply_filters
        return_the @post_comment_reports, handler: tpl_handler
      end

      protected

      def tpl_handler
        'jb'
      end
    end
  end
end
