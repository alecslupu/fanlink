# == Schema Information
#
# Table name: post_comments
#
#  id         :bigint(8)        not null, primary key
#  post_id    :integer          not null
#  person_id  :integer          not null
#  body       :text             not null
#  hidden     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostComment < ApplicationRecord
  include PostComment::PortalFilters
  include PostComment::RealTime

  belongs_to :person, touch: true
  belongs_to :post, touch: true, counter_cache: true

  validates :body, presence: { message: "Comment body is required." }

  has_many :post_comment_mentions, dependent: :destroy

  scope :visible, -> { where(hidden: false) }
  scope :for_product, -> (product) { joins(:post => :person).where(people: {product_id: product.id}) }

  def mentions
    post_comment_mentions
  end

  def mentions=(mention_params)
    mention_params.each do |mp|
      post_comment_mentions.build(person_id: mp["person_id"].to_i, location: mp["location"].to_i, length: mp["length"].to_i)
    end
  end

  def product
    post.product
  end
end
