# == Schema Information
#
# Table name: tags
#
#  id          :bigint(8)        not null, primary key
#  name        :text             not null
#  product_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE), not null
#  posts_count :integer          default(0)
#

class Tag < ApplicationRecord
  self.table_name = :old_tags
  acts_as_tenant(:product)
  belongs_to :product

  has_many :post_tags
  has_many :posts, through: :post_tags
end
