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
  belongs_to :product
  acts_as_tenant(:product)

  validates :title, presence: true
  validates :content, presence: true
  validates :product_id, presence: true
  validates :title, uniqueness: true

  before_save :set_slug

  private

  def set_slug
    self.slug = title.parameterize
  end
end
