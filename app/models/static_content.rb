# == Schema Information
#
# Table name: static_contents
#
#  id         :bigint(8)        not null, primary key
#  content    :jsonb            not null
#  title      :jsonb            not null
#  slug       :string           not null
#  product_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StaticContent < ApplicationRecord
  include TranslationThings

  belongs_to :product
  acts_as_tenant(:product)

  validates :title, presence: true
  validates :content, presence: true
  validates :product_id, presence: true
  validate :title_uniqueness_by_product

  has_manual_translated :title, :content

  before_save :set_slug

  private

  def set_slug
    self.slug = title.parameterize
  end

  def title_uniqueness_by_product
    errors.add(:title) << 'Title must be unique' if uniq?
  end

  def uniq?
    StaticContent.where(product: product).where(title: self[:title]).exists?
  end
end
