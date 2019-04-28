class Api::V4::PersonCertcoursesController < ApiController
  def create
    @person_certcourse = certcourse.person_certcourses.where(person_id: current_user.id).first_or_create!
    @person_certcourse.last_completed_page_id = params[:page_id]

    if certcourse_page.quiz?
      save_user_answer
      if is_correct_answer?
        register_progress
      else
        register_regress
        @person_certcourse.last_completed_page_id = last_certcourse_page.try(:id)
      end
    else
      register_progress
    end

    @person_certcourse.is_completed = last_step?

    if @person_certcourse.save
      PersonCertificate.update_certification_status(@person_certcourse.certcourse.certificate_ids, current_user.id)
      return_the @person_certcourse, handler: "jb"
    else
      render_422(_("Something went wrong."))
    end
  end

  private

  def register_regress
    certcourse_pages.each do |cp|
      next if last_certcourse_page && cp.certcourse_page_order < last_certcourse_page.certcourse_page_order
      break if cp.certcourse_page_order > certcourse_page.certcourse_page_order
      next if cp.quiz?

      update_progress(cp, false)
    end
  end

  def update_progress(cert_page, status)
    progress = cert_page.course_page_progresses.where(person_id: current_user.id).first_or_initialize
    progress.passed = status
    progress.save!
  end

  def register_progress
    update_progress(certcourse_page, true)
  end

  def save_user_answer
    quiz_page_id = params[:quiz_page_id].present? ? params[:quiz_page_id] : certcourse_page.quiz_page.id
    PersonQuiz.create(person_id: current_user.id, quiz_page_id: quiz_page_id, answer_id: params[:answer_id])
  end

  def last_step?
    certcourse_pages.last.id == @person_certcourse.last_completed_page_id
  end

  def last_certcourse_page
    @last_certcourse_page ||= certcourse_pages.where('id < ?', certcourse_page.quiz_page.wrong_answer_page_id).last
  end

  def is_correct_answer?
    (params[:answer_id].present? && Answer.find(params[:answer_id]).is_correct?) || certcourse_page.quiz_page.is_optional?
  end

  def certcourse
    @certcourse ||= Certcourse.find(person_certcourses_params[:certcourse_id])
  end

  def certcourse_pages
    certcourse.certcourse_pages.order("certcourse_page_order")
  end

  def certcourse_page
    @certcoursepage ||= CertcoursePage.find(params[:page_id])
  end


    def person_certcourses_params
      params.require(:person_certcourse).permit(%i[ certcourse_id ])
    end
end
