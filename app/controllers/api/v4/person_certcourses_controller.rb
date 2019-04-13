class Api::V4::PersonCertcoursesController < ApiController
  # TODO refactor!!!!!!
  def create
    @person_certcourse = PersonCertcourse.find_or_create_by(certcourse_id: person_certcourses_params[:certcourse_id], person_id: current_user.id)
    @certcourse_page = CertcoursePage.find(params[:page_id])
    @certcourse = Certcourse.find(person_certcourses_params[:certcourse_id])
    if @certcourse_page.content_type == "quiz"
      if params[:quiz_page_id].present?
        PersonQuiz.create(person_id: current_user.id, quiz_page_id: params[:quiz_page_id], answer_id: params[:answer_id])
      else
        PersonQuiz.create(person_id: current_user.id, quiz_page_id: @certcourse_page.quiz_page.id, answer_id: params[:answer_id])
      end
      if (params[:answer_id].present? && Answer.find(params[:answer_id]).is_correct) || @certcourse_page.quiz_page.is_optional
        @person_certcourse.last_completed_page_id = params[:page_id]
      else
        last_certcourse_page = CertcoursePage.where("id < ? AND certcourse_id = ?", @certcourse_page.quiz_page.wrong_answer_page_id, person_certcourses_params[:certcourse_id]).order("certcourse_page_order").last
        @person_certcourse.last_completed_page_id = last_certcourse_page.present? ? last_certcourse_page.id : nil
      end
    else
      @person_certcourse.last_completed_page_id = params[:page_id]
    end
    if @certcourse.certcourse_pages.order("certcourse_page_order").last.id == @person_certcourse.last_completed_page_id
      @person_certcourse.is_completed = true
    end
    if @person_certcourse.valid?
      @person_certcourse.save

      update_certification_status(@person_certcourse.certcourse.certificate_ids, current_user.id)

      return_the @person_certcourse, handler: "jb"
    else
      render_422(_("Something went wrong."))
    end
  end

  private

    def update_certification_status(certificate_ids, user_id)
      # TODO find a better way to write this
      # TODO move it in a job
      PersonCertificate.where(person_id: user_id, certificate_id: certificate_ids).find_each do |c|
        person_certcourses = PersonCertcourse.where(person_id: user_id, certcourse_id: c.certificate.certcourse_ids).pluck(:is_completed)
        # raise ({c_size: c.certificate.certcourse_ids.size, p_size: person_certcourses.size, pc: person_certcourses}).inspect
        c.is_completed = (c.certificate.certcourses.size == person_certcourses.size) && person_certcourses.inject(true, :&)
        c.save!
      end
    end

    def person_certcourses_params
      params.require(:person_certcourse).permit(%i[ certcourse_id ])
    end
end
