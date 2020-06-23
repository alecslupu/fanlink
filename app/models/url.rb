# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id            :bigint(8)        not null, primary key
#  product_id    :integer          not null
#  displayed_url :text             not null
#  protected     :boolean          default(FALSE)
#  deleted       :boolean          default(FALSE)
#

class Url < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  has_one :reward, -> { where('rewards.reward_type = ?', Reward.reward_types['url']) }, foreign_key: 'reward_type_id'
  has_many :assigned_rewards, through: :reward
end
