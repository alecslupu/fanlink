# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('ConfigItem')
  config.model 'ConfigItem' do
    object_label_method do
      :to_s
    end

    edit do
      fields :item_key, :item_value, :item_url, :item_description
    end
  end
  %w[
    StringConfigItem
    ArrayConfigItem
    BooleanConfigItem
    RootConfigItem
    IntegerConfigItem
    ColorConfigItem
  ].each do |model|
    config.included_models << model
    config.model model do
      parent 'ConfigItem'

      edit do
        fields :item_key, :item_value, :item_url, :item_description
      end
    end
  end
end
