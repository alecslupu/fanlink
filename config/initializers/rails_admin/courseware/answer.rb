RailsAdmin.config do |config|
  config.included_models.push("Answer")

  config.model "Answer" do
    parent "Certificate"

    list do
      exclude_fields :product, :user_answers, :created_at, :updated_at
    end
    edit do
      exclude_fields :product, :user_answers
    end

    nested do
      exclude_fields :quiz_page
    end
  end
end
