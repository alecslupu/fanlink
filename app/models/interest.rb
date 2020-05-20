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

class Interest < ApplicationRecord
  include TranslationThings
  has_manual_translated :title

  acts_as_tenant(:product)

  belongs_to :product
  belongs_to :parent, class_name: "Interest", primary_key: :id, optional: true
  has_many :children, class_name: "Interest", foreign_key: :parent_id, dependent: :destroy
  has_many :person_interests, dependent: :destroy

  accepts_nested_attributes_for :children, allow_destroy: true

  validate :title_not_empty

  scope :interests, -> (product) { where(product_id: product.id, parent_id: nil).order(order: :desc) }

  protected
  def title_not_empty
    errors.add(:title, _("can't be empty.")) if  self.title.blank?
  end
end
