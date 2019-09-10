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

  before_create :set_slug

  private

  def set_slug
    self.slug = self.title.parameterize
  end
end
