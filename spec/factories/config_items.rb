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

FactoryBot.define do
  factory :config_item do
    product { nil }
    item_key { "MyString" }
    type { "" }
    enabled { false }
  end
end