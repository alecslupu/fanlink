module ApplicationHelper

  def parse_node(node)
    if node.is_a?(ArrayConfigItem)
      data = []
      node.children.each do |child|
        data.push(parse_node(child))
      end
    else
      data = {}
      if node.children.size.zero?
        data = node.item_value
      else
        node.children.each do |child|
          if child.children.size > 0
            data[child.item_key] = parse_node(child)
          else
            data[child.item_key] = child.item_value
          end
        end
      end
    end
    data
  end
end
