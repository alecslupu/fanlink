# frozen_string_literal: true

class BaseMention
  def self.parse_body_content(content, product_id)
    mentions = []
    if content.match?(/\[m\|((?:\w*\s*\w*))\]/i)
      content.scanm(/\[m\|((?:\w*\s*\w*))\]/i).each do |mention|
        person = Person.find_by(username_canonical: Person.canonicalize(mention[1]), product_id: product_id)
        if person
          mentions << person
        end
      end
    end
    mentions
  end
end
