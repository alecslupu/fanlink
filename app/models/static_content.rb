# == Schema Information
#
# Table name: contents
#
#  id           :bigint(8)        not null, primary key
#  content      :content          default "", not null
#  title        :string           not null
#  product_id   :integer          not null
#  slug         :string           not null
class StaticContent < ApplicationRecord
  belongs_to :product
  acts_as_tenant(:product)

  validates :title, presence: true, uniqueness: true
  before_create :set_slug

  private

  def set_slug
    self.slug = title.parameterize
  end
end
