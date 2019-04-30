RailsAdmin.config do |config|
  config.included_models.push("ImagePage")
  config.model "ImagePage" do
    parent "Certificate"

    edit do
      fields :certcourse_page, :image
    end
    list do
      fields :id, :certcourse_page, :image, :created_at
    end
    show do
      fields :id, :certcourse_page, :image
    end
  end
end
