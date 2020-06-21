# frozen_string_literal: true

module ApplicationHelper

  def parse_node(node)
    if node.is_a?(ArrayConfigItem)
      data = []
      node.children.enabled.each do |child|
        data.push(parse_node(child))
      end
    elsif node.is_a?(RootConfigItem)
      data = {}
      node.children.enabled.each do |child|
        if child.children.enabled.length > 0
          data[child.item_key] = parse_node(child)
        else
          data[child.item_key] = child.formatted_value
        end
      end
    else
      data = {}
      if node.children.enabled.length.zero?
        data = node.formatted_value
      else
        node.children.enabled.each do |child|
          if child.children.enabled.length > 0
            data[child.item_key] = parse_node(child)
          else
            data[child.item_key] = child.formatted_value
          end
        end
      end
    end
    data
  end
end
