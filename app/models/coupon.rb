# frozen_string_literal: true

# == Schema Information
#
# Table name: coupons
#
#  id          :bigint(8)        not null, primary key
#  product_id  :integer          not null
#  code        :text             not null
#  description :text             not null
#  url         :text
#  deleted     :boolean          default(FALSE)
#

class Coupon < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product
  has_paper_trail

  has_many :rewards, -> { where('rewards.reward_type = ?', Reward.reward_types['coupon']) }, foreign_key: 'reward_type_id'

  normalize_attributes :url
end
