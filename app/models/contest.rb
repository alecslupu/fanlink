# frozen_string_literal: true

# == Schema Information
#
# Table name: contests
#
#  id            :bigint(8)        not null, primary key
#  product_id    :integer          not null
#  name          :text             not null
#  internal_name :text
#  description   :text             not null
#  rules_url     :text
#  contest_url   :text
#  status        :integer          default(0)
#  deleted       :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Contest < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  normalize_attributes :rules_url, :contest_url, with: [ :strip, :blank, :downcase ] do |value|
    value.present? && value.is_a?(String) ? value.downcase : value
  end

  validates :name,
            presence: { message: "Name is required" }
end
