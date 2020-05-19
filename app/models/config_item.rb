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

class ConfigItem < ApplicationRecord
  acts_as_nested_set(
    counter_cache: :children_count, touch: true
  )
  acts_as_tenant(:product)
  rails_admin do
    nested_set(
      max_depth: 5
    )
  end

  scope :for_product, ->(product) { where(product_id: product.id) }

  def formatted_value
    item_value
  end

  validates :type, inclusion: { in: %w[
            StringConfigItem
            ArrayConfigItem
            BooleanConfigItem
            RootConfigItem
            IntegerConfigItem
            ColorConfigItem
  ], message: "%{value} is not a valid type" }

  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }

  def to_s
    item_key
  end
end
