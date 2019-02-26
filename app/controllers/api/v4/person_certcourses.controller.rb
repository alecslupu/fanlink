class Api::V4::PersonCertcoursesController < ApiController
  before_action :load_person_certcourse, only: %i[ update ]

  def create
  	@person_certcourse = PersonCertcourse.new(person_certcourse_params)
  	if @person_certificate.valid?
  	  @person_certificate.save
  	  #set answer to quizzes
      binding.pry
      PersonQuiz.create(person_id: @current_user.id, quiz_page_id: person_certcourse_params[:last_completed_page_id], answer_id: params[:answer_id])
      @certcourse = 
      return_the @certcourse, handler: 'jb'
    else
      render_422(_("Something went wrong."))
    end
  end

  private

  def load_person_certcourse
    @person_certcourse = PersonCertcourse.find(params[:person_certcourse_id])
  end

  def person_certcourses_params
    params.require(:person_certcourse).permit(%i[ certcourse_id last_completed_page_id ])
  end
end