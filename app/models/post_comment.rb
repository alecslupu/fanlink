# frozen_string_literal: true

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
  # include PostComment::PortalFilters
  scope :person_filter, -> (query) { joins(:person).where("people.username_canonical ilike ? or people.email ilike ?", "%#{query}%", "%#{query}%") }
  scope :body_filter, -> (query) { where("post_comments.body ilike ?", "%#{query}%") }
  # include PostComment::PortalFilters
  # include PostComment::RealTime

  scope :reported, -> { joins(:post_comment_reports) }
  scope :not_reported, -> { left_joins(:post_comment_reports).where(post_comment_reports: { id: nil } ) }

  belongs_to :person, touch: true
  belongs_to :post, touch: true, counter_cache: true

  validates :body, presence: { message: "Comment body is required." }

  has_many :post_comment_mentions, dependent: :destroy
  has_many :post_comment_reports, dependent: :destroy

  scope :visible, -> { where(hidden: false) }
  scope :for_product, -> (product) { joins(:post => :person).where(people: { product_id: product.id }) }
  scope :not_reported, -> { left_joins(:post_comment_reports).where("post_comment_reports.id IS NULL OR post_comment_reports.status IN (?)", PostCommentReport.statuses[:no_action_needed]) }

  def mentions
    post_comment_mentions
  end

  def mentions=(mention_params)
    mention_params.each do |mp|
      post_comment_mentions.build(person_id: mp["person_id"].to_i, location: mp["location"].to_i, length: mp["length"].to_i)
    end
  end

  def name
    body
  end

  def product
    post.product
  end
end
