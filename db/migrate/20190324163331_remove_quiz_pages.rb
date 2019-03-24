class RemoveQuizPages < ActiveRecord::Migration[5.1]
  module Migrated

    class QuizPage < ActiveRecord::Base
      self.table_name =  "quiz_pages"
      has_many :answers, class_name: Migrated::Answer
    end

    class Answer < ActiveRecord::Base
      self.table_name =  "answers"
      belongs_to :quiz_page, class_name: Migrated::QuizPage
    end
  end

  def up

    CertcoursePage.where(type: 'video').update_all(type: VideoPage.name)
    CertcoursePage.where(type: 'image').update_all(type: ImagePage.name)
    CertcoursePage.where(type: 'quiz').update_all(type: QuizPage.name)

    remove_foreign_key "answers", name: "fk_answers_quiz"
    remove_foreign_key "person_quizzes", name: "fk_person_quiz_pages_quiz_page_id"

    Migrated::Answer.find_each do |answer|
      answer.update_attribute(:quiz_page_id, answer.quiz_page.certcourse_page_id )
    end
    Migrated::QuizPage.find_each do |mgp|
      PersonQuiz.where(quiz_page_id: mgp.id).update_all(quiz_page_id: mgp.certcourse_page_id)
      cp = CertcoursePage.find(mgp.certcourse_page_id)
      cp.type = QuizPage.name
      cp.is_optional = mgp.is_optional
      cp.quiz_text = mgp.quiz_text
      cp.save!
    end

    rename_column "answers", "quiz_page_id", "certcourse_page_id"
    rename_column "person_quizzes", "quiz_page_id", "certcourse_page_id"

    drop_table :quiz_pages

    add_foreign_key "answers", "certcourse_pages", name: "fk_answers_quiz"
    add_foreign_key "person_quizzes", "certcourse_pages", name: "fk_person_quiz_pages_quiz_page_id"

  end

  def down

    create_table "quiz_pages", force: :cascade do |t|
      t.integer "certcourse_page_id"
      t.boolean "is_optional", default: false
      t.string "quiz_text", default: "", null: false
      t.integer "wrong_answer_page_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["certcourse_page_id"], name: "idx_quiz_pages_certcourse_page"
    end


    remove_foreign_key "person_quizzes", name: "fk_person_quiz_pages_quiz_page_id"
    rename_column "person_quizzes", "quiz_page_id", "certcourse_page_id"
    add_foreign_key "person_quizzes", "quiz_pages", name: "fk_person_quiz_pages_quiz_page_id"


    remove_foreign_key "answers", name: "fk_answers_quiz"
    add_foreign_key "answers", "quiz_pages", name: "fk_answers_quiz"
    rename_column "answers", "certcourse_page_id", "quiz_page_id"


    add_foreign_key "quiz_pages", "certcourse_pages", name: "fk_quiz_pages_certcourse_page"

  end
end
