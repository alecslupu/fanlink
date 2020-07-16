# frozen_string_literal: true

# == Schema Information
#
# Table name: static_web_contents
#
#  id         :bigint(8)        not null, primary key
#  content    :jsonb            not null
#  title      :jsonb            not null
#  slug       :string           not null
#  product_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Static
  class WebContent < Fanlink::Static::WebContent
  end
end
