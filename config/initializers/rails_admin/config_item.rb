RailsAdmin.config do |config|
  config.included_models.push("ConfigItem")
  config.model "ConfigItem" do
    object_label_method do
      :to_s
    end

    edit do
      fields :product, :item_key, :item_value, :item_url, :item_description, :enabled
    end
  end
  %w(
    StringConfigItem
    ArrayConfigItem
    BooleanConfigItem
    RootConfigItem
    IntegerConfigItem
  ).each do |model|
    config.included_models << model
    config.model model do
      parent "ConfigItem"

      edit do
        fields :product, :item_key, :item_value, :item_url, :item_description, :enabled
      end
    end
  end
end
