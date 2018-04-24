class PostComment < ApplicationRecord
  include PostComment::PortalFilters
  belongs_to :person
  belongs_to :post
  validates :body, presence: true

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
end