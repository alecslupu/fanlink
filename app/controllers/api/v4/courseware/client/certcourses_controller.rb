module Api
  module V4
    module Courseware
      module Client
        class CertcoursesController < BaseController
          # frozen_string_literal: true

          def index
            if PersonCertificate.where(person_id: params[:person_id], certificate_id: params[:certificate_id]).present?
              @certificate = Certificate.find(params[:certificate_id])
              @assignee = Person.find(params[:person_id])
              @certcourses = @certificate.certcourses.live_status
              return_the @certcourses, handler: :jb
            else
              render_422 _('This user does not have the requested certificate.')
            end
          end

          def show
            #  fill in response on person quizz is not taken into consideration YET
            certcourse_pages = CertcoursePage.where(certcourse_id: params[:id], content_type: 'quiz')
            if certcourse_pages.present?
              @quizzes = []
              certcourse_pages.each do |certcourse_page|
                quiz_page = QuizPage.find_by(certcourse_page_id: certcourse_page.id)

                next if quiz_page.blank?

                person_responses = PersonQuiz.where(person_id: params[:person_id], quiz_page_id: quiz_page.id)

                next if person_responses.blank?

                correct_answer = Answer.find_by(quiz_page_id: quiz_page.id, is_correct: true)
                failed_attempts = person_responses.where.not(answer_id: correct_answer.id)
                no_of_failed_attempts = failed_attempts.count

                # change this with "where" and the response in case of multiple correct answer possibility
                person_correct_answer = person_responses.find_by(answer_id: correct_answer.id) unless no_of_failed_attempts == person_responses.count

                if person_correct_answer.present?
                  answer_text = correct_answer.description
                  is_correct = true
                  # elsif quiz_page.is_survey
                  #   is_correct = true
                  #   answer_text = person_response.fill_in_response.present?
                else
                  is_correct = false
                  answer_text = failed_attempts.present? ? Answer.find(failed_attempts.last.answer_id).description : nil
                end

                quiz = {
                  id: quiz_page.id,
                  is_optional: quiz_page.is_optional,
                  is_survey: quiz_page.is_survey,
                  quiz_text: quiz_page.quiz_text,
                  certcourse_pages_count: Certcourse.find(certcourse_page.certcourse_id).certcourse_pages_count,
                  page_order: certcourse_page.certcourse_page_order,
                  no_of_failed_attempts: no_of_failed_attempts,
                  answer_text: answer_text,
                  is_correct: is_correct
                }

                @quizzes << quiz
              end

              return_the @quizzes, handler: :jb
            else
              render_404(_('This certificates has no quiz page.'))
            end
          end
        end
      end
    end
  end
end
