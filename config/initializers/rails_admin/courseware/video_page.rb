RailsAdmin.config do |config|
  config.included_models.push("VideoPage")
  config.model "VideoPage" do
    parent "Certificate"

    configure :course_name do
    end

    edit do
      field :certcourse_page
      field :video, :paperclip
    end
    list do
      fields :id, :course_name, :video, :created_at
    end
    show do
      fields :id, :certcourse_page, :video
    end

    nested do
      exclude_fields :certcourse_page
    end
  end
end
