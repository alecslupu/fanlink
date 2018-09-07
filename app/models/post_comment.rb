class PostComment < ApplicationRecord
  include PostComment::PortalFilters
  include PostComment::RealTime

  belongs_to :person, touch: true
  belongs_to :post, touch: true
  
  validates :body, presence: { message: "Comment body is required." }

  has_many :post_comment_mentions, dependent: :destroy

  scope :visible, -> { where(hidden: false) }

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
