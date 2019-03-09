class Api::V4::PersonCertcoursesController < ApiController

  def create
    @person_certcourse = PersonCertcourse.find_or_create_by(certcourse_id: person_certcourses_params[:certcourse_id],person_id: @current_user.id)
    @person_certcourse.last_completed_page_id = person_certcourses_params[:last_completed_page_id]
  	if @person_certcourse.valid?
  	  @person_certcourse.save
      if params[:answer_id]
        PersonQuiz.create(person_id: @current_user.id, quiz_page_id: params[:quiz_page_id], answer_id: params[:answer_id])
      end
      return_the @person_certcourse, handler: 'jb'
    else
      render_422(_("Something went wrong."))
    end
  end

  private

  def person_certcourses_params
    params.require(:person_certcourse).permit(%i[ certcourse_id last_completed_page_id ])
  end
end
