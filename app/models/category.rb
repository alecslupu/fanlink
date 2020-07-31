# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :text             not null
#  product_id  :integer          not null
#  role        :integer          default("normal"), not null
#  color       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE), not null
#  posts_count :integer          default(0)
#

class Category < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product
  has_many :posts, dependent: :nullify

  normalize_attributes :color

  enum role: { normal: 0, product: 1, staff: 2, admin: 3, super_admin: 4 }

  validates :name,
            presence: { message: _('Name is required.') },
            length: { in: 3..26, message: _('Name must be between 3 and 26 characters.') },
            uniqueness: { scope: :product_id, allow_nil: false, message: _('A category already exists with this name.') }

  validates :color, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/, message: ->(*) { _('Color must be a hexadecimal value.') } }

  scope :for_admin, -> { where(role: %i[normal product staff admin]) }
  scope :for_user, -> { where(role: [:normal]) }
  scope :for_super_admin, -> { where(role: %i[normal product staff admin super_admin]) }
  scope :for_product_account, -> { where(role: [:product]) }
end
