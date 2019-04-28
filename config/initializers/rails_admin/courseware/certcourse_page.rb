RailsAdmin.config do |config|
  config.included_models.push("CertcoursePage")

  config.model "CertcoursePage" do
    parent "Certificate"

    show do
      fields :id,
             :certcourse,
             :quiz_page,
             :video_page,
             :image_page,
             :certcourse_page_order,
             :duration,
             :background_color_hex
    end
    edit do
      fields :certcourse,
             :certcourse_page_order,
             :duration,
             :background_color_hex
    end
    list do
      fields :id,
             :certcourse,
             :content_type,
             :certcourse_page_order
    end
  end
end
