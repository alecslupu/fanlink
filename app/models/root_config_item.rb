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

class RootConfigItem < ConfigItem
  has_paper_trail

  def to_s
    if item_value.present?
      "#{item_key} (#{item_value})"
    else
      item_key
    end
  end

  def self.copy_tree(from_id, product_id)
    product = Product.find(product_id)
    ConfigItem.find_each { |ci| ConfigItem.reset_counters(ci.id, :children) }
    root = RootConfigItem.find(from_id)
    new_root = ActsAsTenant.with_tenant(product) {
      root.class.create!(
        item_key: root.item_key,
        item_value: root.item_value,
        enabled: root.enabled,
        item_url: root.item_url,
        item_description: root.item_description
      )
    }
    root.children.each do |original_node|
      copy_node(original_node, new_root, product)
    end
  end

  def self.copy_node(original_node, new_root, product)
    new_node = ActsAsTenant.with_tenant(product) {
      original_node.class.create!(
        item_key: original_node.item_key,
        item_value: original_node.item_value,
        enabled: original_node.enabled,
        item_url: original_node.item_url,
        item_description: original_node.item_description
      )
    }
    new_node.move_to_child_of(new_root)
    if original_node.children.size > 0
      original_node.children.each { |node| copy_node(node, new_node, product) }
    end
  end
end
