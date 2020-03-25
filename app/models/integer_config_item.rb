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

class IntegerConfigItem < ConfigItem
  has_paper_trail

  validates :item_value, numericality: true, presence: true

  before_save :strip_blanks

  def formatted_value
    item_value.try(:to_i)
  end

  private


  def strip_blanks
    self.item_value = self.item_value.strip
  end
end
