# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("DownloadFilePage")
  config.model "DownloadFilePage" do
    parent "Certificate"

    configure :course_name do
    end

    edit do
      fields :certcourse_page, :caption
      field :document, :paperclip
    end
    list do
      fields :id, :course_name, :caption, :document, :created_at, :updated_at
    end
    show do
      fields :id, :certcourse_page, :caption, :document
    end

    nested do
      exclude_fields :certcourse_page
    end
  end
end
