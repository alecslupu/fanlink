# frozen_string_literal: true
# == Schema Information
#
# Table name: config_items
#
#  id               :bigint(8)        not null, primary key
#  product_id       :bigint(8)
#  item_key         :string
#  item_value       :string
#  type             :string
#  enabled          :boolean          default(TRUE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  parent_id        :integer
#  lft              :integer          default(0), not null
#  rgt              :integer          default(0), not null
#  depth            :integer          default(0), not null
#  children_count   :integer          default(0)
#  item_url         :string
#  item_description :string
#

FactoryBot.define do
  factory :config_item, class: "ConfigItem" do
    product { current_product }
    item_key { "MyString" }
    enabled { false }

    factory :string_config_item, class: "StringConfigItem" do
    end
    factory :array_config_item, class: "ArrayConfigItem" do
    end
    factory :boolean_config_item, class: "BooleanConfigItem" do
    end
    factory :root_config_item, class: "RootConfigItem" do
    end
  end
end
