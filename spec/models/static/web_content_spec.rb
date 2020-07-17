# frozen_string_literal: true

# == Schema Information
#
# Table name: static_web_contents
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  product_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public     :boolean          default(FALSE)
#


require 'rails_helper'

RSpec.describe Static::WebContent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
