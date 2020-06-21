# frozen_string_literal: true


module Api
  module V4
    class PostReportsController < Api::V3::PostReportsController
      def index
        @post_reports = paginate apply_filters
        return_the @post_reports, handler: tpl_handler
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
