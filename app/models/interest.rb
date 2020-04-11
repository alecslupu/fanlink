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
  has_paper_trail

  translates :title, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  acts_as_tenant(:product)

  belongs_to :product
  belongs_to :parent, class_name: "Interest", primary_key: :id, optional: true
  has_many :children, class_name: "Interest", foreign_key: :parent_id, dependent: :destroy
  has_many :person_interests, dependent: :destroy

  accepts_nested_attributes_for :children, allow_destroy: true

  scope :for_product, -> (product) { where( interests: { product_id: product.id } ) }

  validate :title_not_empty

  scope :interests, -> (product) { for_product(product).where( parent_id: nil).order(order: :desc) }

  protected
  def title_not_empty
    errors.add(:title, _("can't be empty.")) unless  self.title.present?
  end
end
