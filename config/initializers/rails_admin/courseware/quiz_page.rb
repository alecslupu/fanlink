RailsAdmin.config do |config|
  config.included_models.push("QuizPage")
  config.model "QuizPage" do
    parent "Certificate"


    edit do
      fields :certcourse_page, :answers, :is_optional, :quiz_text, :wrong_answer_page_id
    end
    list do
      fields :id, :certcourse_page, :answers, :is_optional
    end
    show do
      fields :id, :certcourse_page, :answers, :is_optional, :quiz_text, :wrong_answer_page_id
    end
  end
end
