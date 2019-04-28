RailsAdmin.config do |config|
  config.included_models.push("VideoPage")
  config.model "VideoPage" do
    parent "Certificate"

    edit do
      field :certcourse_page
      field :video, :paperclip
    end
    list do
      fields :id, :certcourse_page, :video, :created_at
    end
    show do
      fields :id, :certcourse_page, :video
    end
  end
end
# require "administrate/base_dashboard"
#
# class VideoPageDashboard < Administrate::BaseDashboard
#   ATTRIBUTE_TYPES = {
#     certcourse_page: Field::BelongsTo.with_options(order: :id),
#     id: Field::Number,
#     video_url: Field::String,
#     created_at: Field::DateTime,
#     updated_at: Field::DateTime,
#     video: PaperclipVideoField,
#   }.freeze
# end
