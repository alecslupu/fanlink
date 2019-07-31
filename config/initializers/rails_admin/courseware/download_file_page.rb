RailsAdmin.config do |config|
  config.included_models.push("DownloadFilePage")
  config.model "DownloadFilePage" do
    parent "Certificate"

    configure :course_name do
    end

    edit do
      field :certcourse_page
      field :document, :paperclip
    end
    list do
      fields :id, :course_name, :document, :created_at
    end
    show do
      fields :id, :certcourse_page, :document
    end

    nested do
      exclude_fields :certcourse_page
    end
  end
end
