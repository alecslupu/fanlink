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

class HackedMetric < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :action_type
  belongs_to :person
end
