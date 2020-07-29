# frozen_string_literal: true

module Api
  module V4
    class CertcoursesController < ApiController

      def index
        @certificate = Fanlink::Courseware::Certificate.find(params[:certificate_id])
        @certcourses = paginate @certificate.courses.live.order(:course_order)
        return_the @certcourses, handler: tpl_handler
      end

      def show
        @certcourse = Fanlink::Courseware::Course.find(params[:id])
        return_the @certcourse, handler: tpl_handler
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
