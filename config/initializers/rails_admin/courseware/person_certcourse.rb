# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("PersonCertcourse")
  config.model "PersonCertcourse" do
    parent "Certificate"

    edit do
      fields :person,
             :certcourse,
             :last_completed_page_id,
             :is_completed
    end
    list do
      fields :id, :person, :certcourse, :last_completed_page_id
    end
    show do
      fields :id,
             :person,
             :certcourse,
             :last_completed_page_id,
             :is_completed
    end
  end
end
