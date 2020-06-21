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

class StringConfigItem < ConfigItem
  has_paper_trail
  before_validation :downcase
  validate :custom_validation

  protected

  def downcase
    item_value.downcase! if item_key == "tab_id"
  end

  def custom_validation
    if item_key == "tab_id"
      valid_options = %w{ education chat discover feed profile product events trivia menu client_settings client_menu client_users }
      errors.add(:item_value, "Please specify any of the #{valid_options.inspect}") unless valid_options.include?(item_value)
    end
  end
end
