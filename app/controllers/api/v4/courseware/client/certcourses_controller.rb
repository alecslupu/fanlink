class Api::V4::Courseware::Client::CertcoursesController < Api::V4::Courseware::Client::BaseController
  # frozen_string_literal: true
  # cauti cursurile ptr acel certificat
    # le poti da id-ul quizz-ului la show
  def index
    @certificate = Certificate.find(params[:certificate_id])
    @certcourses = @certificate.certcourses
    return_the @certcourses, handler: :jb
  end

  def show
    quiz1 = {
      id: 1,
      is_optional: false,
      no_of_failed_attempts: rand(20),
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 25,
      page_order: 12,
      is_correct: true
    }

    quiz2 = {
      id: 2,
      is_optional: true,
      no_of_failed_attempts: 1,
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 36,
      page_order: 8,
      is_correct: false
    }

    quiz3 = {
      id: 3,
      is_optional: false,
      no_of_failed_attempts: rand(20),
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 25,
      page_order: 12,
      is_correct: true
    }

    quiz4 = {
      id: 4,
      is_optional: true,
      no_of_failed_attempts: 0,
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 36,
      page_order: 8,
      is_correct: true
    }

    quiz5 = {
      id: 5,
      is_optional: false,
      no_of_failed_attempts: rand(20),
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 25,
      page_order: 12,
      is_correct: false
    }

    @quizzes = [quiz1, quiz2, quiz3, quiz4, quiz5]
    return_the @quizzes, handler: :jb
  end
end
