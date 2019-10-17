# == Schema Information
#
# Table name: static_contents
#
#  id         :bigint(8)        not null, primary key
#  content    :text             not null
#  title      :string           not null
#  slug       :string           not null
#  product_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StaticContent < ApplicationRecord
  belongs_to :product
  acts_as_tenant(:product)

  validates :title, presence: true
  validates :content, presence: true
  validates :product_id, presence: true
  validates :title, uniqueness: true

  before_save :set_slug

  after_save :expire_cache
  before_destroy :expire_cache, prepend: true

  private

  def set_slug
    self.slug = title.parameterize
  end

  def expire_cache
    ActionController::Base.expire_page(Rails.application.routes.url_helpers.cache_static_content_path(product: product.internal_name, slug: slug))
  end
end
