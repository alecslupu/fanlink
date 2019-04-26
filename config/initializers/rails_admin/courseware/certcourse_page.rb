RailsAdmin.config do |config|
  config.included_models.push("CertcoursePage")

  config.model "CertcoursePage" do
    parent "Certificate"

    show do
      fields :certcourse, :quiz_page, :video_page, :image_page, :id, :certcourse_page_order, :duration
      fields :background_color_hex, :created_at, :updated_at
    end
    edit do
      fields :certcourse, :certcourse_page_order, :duration, :background_color_hex
    end
    list do
      fields :id, :certcourse, :content_type, :certcourse_page_order
    end
  end
end
