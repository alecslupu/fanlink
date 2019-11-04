class Api::V4::Courseware::Client::CertcoursesController < Api::V4::Courseware::Client::BaseController
  # frozen_string_literal: true
  # cauti cursurile ptr acel certificat
    # le poti da id-ul quizz-ului la show
  def index
    certificate = Certificate.find(params[:certificate_id])
    @certcourses = certificate.certcourses
    return_the @certcourses, handler: :jb
  end

  def show
    certcourse_pages = CertcoursePage.where(certcourse_id: params[:id], content_type: :quiz)
    certcourse_pages.present? ? @quizzes = [] : return head :no_content # testeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaza
    certcourse_pages.each do |certcourse_page|
      quiz_page = QuizPage.find_by(certcourse_page_id: id)
      quiz = {
        id: id,
        is_optional: quiz_page.is_optional,
        is_survey: quiz_page.is_survey,
        quiz_text: quiz_page.quiz_text,
        certcourse_pages_count: certcourse_page.certcourse_pages_count,
        page_order: certcourse_page.certcourse_page_order

      }
    end
    # <PersonQuiz id: 1, person_id: 36505, quiz_page_id: 2, answer_id: 6, fill_in_response: nil, created_at: "2019-03-16 02:26:21",
    # updated_at: "2019-03-16 02:26:21">,

    #<PersonQuiz id: 2, person_id: 36505, quiz_page_id: 3, answer_id: 7, fill_in_response: nil,
    # created_at: "2019-03-16 02:26:35", updated_at: "2019-03-16 02:26:35">


    # <Answer id: 6, quiz_page_id: 2, description: "Prepare your interview outfit the morning of your ...", is_correct: true,
    # created_at: "2019-03-15 21:36:25", updated_at: "2019-03-15 21:36:25", product_id: 17>

    # <QuizPage id: 2, certcourse_page_id: 30, is_optional: false, quiz_text: " To prepare for an interview, which of the follow ...",
    # wrong_answer_page_id: 27, created_at: "2019-03-15 21:35:09", updated_at: "2019-03-16 04:22:46", product_id: 17, is_survey: false>

    # @quizzes = [quiz1, quiz2, quiz3, quiz4, quiz5]
    return_the @quizzes, handler: :jb
  end
end

    # quiz1 = {
    #   id: 1, +
    #   is_optional: false, +
    #   no_of_failed_attempts: rand(20),
    #   quiz_text: Faker::Lorem.sentence, +
    #   answer_text: Faker::Lorem.sentence,
    #   certcourse_pages_count: 25,     +
    #   page_order: 12,   +
    #   is_correct: true,
    #   is_survey
    # }
