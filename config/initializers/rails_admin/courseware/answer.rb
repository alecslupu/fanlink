# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Answer')

  config.model 'Answer' do
    parent 'Certificate'

    configure :question do
    end
    configure :certcourse_name do
    end
    show do
      fields :quiz_page,
            :id,
            :description,
            :is_correct
    end
    list do
      fields :id,
            :certcourse_name,
            :question,
            :description,
            :is_correct
    end
    edit do
      fields :quiz_page,
            :description,
            :is_correct
    end

    nested do
      exclude_fields :quiz_page
    end
  end
end
