# == Schema Information
#
# Table name: config_items
#
#  id             :bigint(8)        not null, primary key
#  product_id     :bigint(8)
#  item_key       :string
#  item_value     :string
#  type           :string
#  enabled        :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  parent_id      :integer
#  lft            :integer          default(0), not null
#  rgt            :integer          default(0), not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0)
#

class ConfigItem < ApplicationRecord
  acts_as_nested_set
  acts_as_tenant(:product)


  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
  def to_s
    item_key
  end
end
