# frozen_string_literal: true
# == Schema Information
#
# Table name: followings
#
#  id          :bigint(8)        not null, primary key
#  follower_id :integer          not null
#  followed_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Following < ApplicationRecord
  default_scope -> { order(Arel.sql 'followings.created_at DESC, followings.id DESC') }
  has_paper_trail ignore: [:created_at, :updated_at]

  belongs_to :follower, class_name: "Person", touch: true
  belongs_to :followed, class_name: "Person", touch: true

  validates :followed_id, uniqueness: { scope: :follower_id, message: _("You are already following that person.") }
  validate :people_from_same_product

  scope :for_product, -> (product) { joins("JOIN people ON people.id = followings.follower_id").where("people.product_id = ?", product.id) }

  private

    def people_from_same_product
      errors.add(
        :base,
        :different_product,
        message: _("You cannot follow a person from a different product")
      ) if follower&.product_id != followed&.product_id
    end

end
