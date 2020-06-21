# frozen_string_literal: true

# == Schema Information
#
# Table name: interests
#
#  id         :bigint(8)        not null, primary key
#  product_id :integer          not null
#  parent_id  :integer
#  title      :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order      :integer          default(0), not null
#

require "faker"

FactoryBot.define do
  factory :interest do
    product { current_product }
    title { Faker::ProgrammingLanguage.name }
  end
end
