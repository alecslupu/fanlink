# frozen_string_literal: true
# == Schema Information
#
# Table name: hacked_metrics
#
#  id             :bigint(8)        not null, primary key
#  product_id     :integer          not null
#  person_id      :integer          not null
#  action_type_id :integer          not null
#  identifier     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :hacked_metric do
    product { current_product }
    person { create(:person) }
    action_type { create(:action_type) }
    identifier { rand(10) }
  end
end
