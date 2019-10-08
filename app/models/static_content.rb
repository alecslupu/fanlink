# == Schema Information
#
# Table name: contents
#
#  id           :bigint(8)        not null, primary key
#  content      :jsonb            default "", not null
#  title        :jsonb            not null
#  product_id   :integer          not null
#  slug         :string           not null
class StaticContent < ApplicationRecord
  include TranslationThings

  belongs_to :product
  acts_as_tenant(:product)

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :product_id, presence: true

  has_manual_translated :title, :content
  before_create :set_slug

  private

  def set_slug
    self.slug = title.parameterize
  end
end
