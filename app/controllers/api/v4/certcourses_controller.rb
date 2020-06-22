# frozen_string_literal: true

class Api::V4::CertcoursesController < ApiController
  load_up_the Certificate, from: :certificate_id

  def index
    @certcourses = paginate @certificate.certcourses.live_status.order(:certcourse_order)
    return_the @certcourses, handler: tpl_handler
  end

  def show
    @certcourse = Certcourse.find(params[:id])
    return_the @certcourse, handler: tpl_handler
  end

  protected

    def tpl_handler
      :jb
    end
end
