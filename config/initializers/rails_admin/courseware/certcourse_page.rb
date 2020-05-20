# frozen_string_literal: true
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
             :download_file_page,
             :certcourse_page_order,
             :duration,
             :background_color_hex
    end
    edit do
      fields :certcourse,
             :certcourse_page_order,
             :duration,
             :background_color_hex,
             :quiz_page,
             :video_page,
             :image_page,
             :download_file_page
    end

    list do
      scopes [ nil, :quizes, :videos, :images, :download_files ]
      fields :id,
             :certcourse,
             :content_type,
             :certcourse_page_order
    end

    nested do
      [:quiz_page, :image_page, :video_page, :download_file_page].each do |configured_model|
        field configured_model do
          visible do
            bindings[:object].persisted?
          end
        end
      end
      exclude_fields :certcourse
    end
  end
end
