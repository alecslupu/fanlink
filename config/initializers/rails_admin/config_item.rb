RailsAdmin.config do |config|
  config.included_models.push("ConfigItem")
  config.model "ConfigItem" do
    object_label_method do
      :to_s
    end

    edit do
      fields :product, :item_key, :item_value, :enabled
    end
  end
end
