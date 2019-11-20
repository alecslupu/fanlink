class ColorConfigItem < ConfigItem
  has_paper_trail
  validates :item_value, css_hex_color: true
end
