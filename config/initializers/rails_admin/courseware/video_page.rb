# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("VideoPage")
  config.model "VideoPage" do
    parent "Certificate"

    configure :course_name do
    end

    edit do
      field :certcourse_page
      field :video
    end
    list do
      field :id
      field :course_name do
        searchable [{ Certcourse => :short_name }]
        queryable true
      end
      fields :video, :created_at, :updated_at
    end
    show do
      fields :id, :certcourse_page, :video
    end

    nested do
      exclude_fields :certcourse_page
    end
  end
end
