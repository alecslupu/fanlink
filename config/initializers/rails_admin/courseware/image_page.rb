# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("ImagePage")
  config.model "ImagePage" do
    parent "Certificate"

    configure :course_name do
    end

    edit do
      fields :certcourse_page, :image
    end
    list do
      field :id
      field :course_name do
        searchable [{ Certcourse => :short_name }]
        queryable true
      end
      fields :image, :created_at, :updated_at
    end
    show do
      fields :id, :certcourse_page, :image
    end

    nested do
      exclude_fields :certcourse_page
    end
  end
end
