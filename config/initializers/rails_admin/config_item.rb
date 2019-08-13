RailsAdmin.config do |config|
  config.included_models.push("ConfigItem")
  config.model "ConfigItem" do
    # nested_set({
    #    max_depth: 3,
    #    toggle_fields: [:enabled],
    #    # thumbnail_fields: [:image, :cover],
    #    # thumbnail_size: :thumb,
    #    # thumbnail_gem: :paperclip, # or :carrierwave
    #    scopes: [:enabled, :disabled] # filter nodes by scope
    #  })
    object_label_method do
      :to_s
    end

    edit do
      fields :product, :item_key, :item_value, :enabled
    end
  end
end
