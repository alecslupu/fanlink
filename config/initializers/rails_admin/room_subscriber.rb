RailsAdmin.config do |config|
  config.included_models.push("RoomSubscriber")

  config.model "RoomSubscriber" do
    label_plural "Room Owners"
    # list do
    #   fields :id,
    #          :title,
    #          :content,
    #          :slug
    # end
    #
    # edit do
    #   field :title, :translated
    #   field :content, :translated do
    #     html_attributes rows: 20, cols: 50
    #   end
    # end
    #
    # show do
    #   fields :id,
    #          :title,
    #          :content,
    #          :slug
    # end
  end
end
