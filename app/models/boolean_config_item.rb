class BooleanConfigItem < ConfigItem

  def item_value
    self[:item_value] == "t"
  end
end
