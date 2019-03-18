class Api::V4::PersonCertcoursesController < ApiController

  def create
    @person_certcourse = PersonCertcourse.find_or_create_by(certcourse_id: person_certcourses_params[:certcourse_id],person_id: @current_user.id)
  	@certcourse_page = CertcoursePage.find(params[:page_id])
    if @certcourse_page.content_type == "quiz"
      if params[:quiz_page_id].present?
        PersonQuiz.create(person_id: @current_user.id, quiz_page_id: params[:quiz_page_id], answer_id: params[:answer_id])
      else
        PersonQuiz.create(person_id: @current_user.id, quiz_page_id: @certcourse_page.quiz_page.id, answer_id: params[:answer_id])
      end
      if params[:answer_id].present? && Answer.find(params[:answer_id]).is_correct
        @person_certcourse.last_completed_page_id = params[:page_id]
      else
        @person_certcourse.last_completed_page_id = CertcoursePage.where("id < ? AND certcourse_id = ?", @certcourse_page.quiz_page.wrong_answer_page_id, person_certcourses_params[:certcourse_id]).order("certcourse_page_order").last.id
      end
    else 
      @person_certcourse.last_completed_page_id = params[:page_id]
    end
    if @person_certcourse.valid?
      @person_certcourse.save
      return_the @person_certcourse, handler: 'jb'
    else
      render_422(_("Something went wrong."))
    end
  end

  private

  def person_certcourses_params
    params.require(:person_certcourse).permit(%i[ certcourse_id ])
  end
end
