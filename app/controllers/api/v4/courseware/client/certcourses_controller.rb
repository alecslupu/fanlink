class Api::V4::Courseware::Client::CertcoursesController < Api::V4::Courseware::Client::BaseController
  # frozen_string_literal: true

  def index
    if PersonCertificate.where(person_id: params[:person_id], certificate_id: params[:certificate_id]).present?
      certificate = Certificate.find(params[:certificate_id])
      @certcourses = certificate.certcourses
      return_the @certcourses, handler: :jb
    else
      render_422 _('This user does not have the requested certificate.')
    end
  end

  def show
    certcourse_pages = CertcoursePage.where(certcourse_id: params[:id], content_type: :quiz)
    certcourse_pages.present? ? @quizzes = [] : (head :no_content && return) # testeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaza
    certcourse_pages.each do |certcourse_page|
      quiz_page = QuizPage.find_by(certcourse_page_id: id)
      correct_answer = Answer.find_by(quiz_page_id: quiz_page.id, is_correct: true)
      person_responses = PersonQuiz.where(person_id: params[:person_id], quiz_page_id: quiz_page.id)
      failed_attempts = person_responses.where.not(answer_id: correct_answer.id)
      no_of_failed_attempts = failed_attempts.count

      # change this with "where" and the response in case of multiple correct answer possibility
      person_correct_answer = person_responses.find_by(answer_id: correct_answer.id) unless no_of_failed_attempts == person_responses.count

      if person_correct_answer.present?
        answer_text = correct_answer.description
        is_correct = true
      else
        answer_text = Answer.find_by(failed_attempts.last.answer_id).description
        is_correct = false
      end
      quiz = {
        id: id,
        is_optional: quiz_page.is_optional,
        is_survey: quiz_page.is_survey,
        quiz_text: quiz_page.quiz_text,
        certcourse_pages_count: Certcourse.find(certcourse_page.id).certcourse_pages_count,
        page_order: certcourse_page.certcourse_page_order,
        no_of_failed_attempts: no_of_failed_attempts,
        answer_text: answer_text,
        is_correct: is_correct
      }
    end
    return_the @quizzes, handler: :jb
  end
end
    # <PersonQuiz id: 1, person_id: 36505, quiz_page_id: 2, answer_id: 6, fill_in_response: nil, created_at: "2019-03-16 02:26:21",
    # updated_at: "2019-03-16 02:26:21">,

    #<PersonQuiz id: 2, person_id: 36505, quiz_page_id: 3, answer_id: 7, fill_in_response: nil,
    # created_at: "2019-03-16 02:26:35", updated_at: "2019-03-16 02:26:35">


    # <Answer id: 6, quiz_page_id: 2, description: "Prepare your interview outfit the morning of your ...", is_correct: true,
    # created_at: "2019-03-15 21:36:25", updated_at: "2019-03-15 21:36:25", product_id: 17>

    # <QuizPage id: 2, certcourse_page_id: 30, is_optional: false, quiz_text: " To prepare for an interview, which of the follow ...",
    # wrong_answer_page_id: 27, created_at: "2019-03-15 21:35:09", updated_at: "2019-03-16 04:22:46", product_id: 17, is_survey: false>

    # <Certcourse id: 1, long_name: "cacacaa", short_name: "cac", description: "Test no pages 8", color_hex: "#000000", status: "entry",
    # duration: 5568798, is_completed: false, copyright_text: "text", created_at: "2019-03-11 18:34:20", updated_at: "2019-10-08 11:50:16",
    # product_id: 2, certcourse_pages_count: 5>

    # @quizzes = [quiz1, quiz2, quiz3, quiz4, quiz5]

    # quiz1 = {
    #   id: 1, +
    #   is_optional: false, +
    #   no_of_failed_attempts: rand(20),  +
    #   quiz_text: Faker::Lorem.sentence, +
    #   answer_text: Faker::Lorem.sentence,
    #   certcourse_pages_count: 25,     +
    #   page_order: 12,   +
    #   is_correct: true,  +
    #   is_survey          +
    # }
