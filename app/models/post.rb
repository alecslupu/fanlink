class Post < ApplicationRecord
  include AttachmentSupport
  include TranslationThings

  enum status: %i[ pending published deleted rejected errored ]

  has_manual_translated :body

  has_image_called :picture
  has_paper_trail

  has_many :post_reports, dependent: :destroy
  has_many :post_reactions

  belongs_to :person

  validate :sensible_dates

  scope :following_and_own, -> (follower) { includes(:person).where(person: follower.following + [follower]) }

  scope :for_person, -> (person) { includes(:person).where(person: person) }
  scope :for_product, -> (product) { joins(:person).where("people.product_id = ?", product.id) }
  scope :in_date_range, -> (start_date, end_date) {
                              where("posts.created_at >= ? and posts.created_at <= ?",
                                start_date.beginning_of_day, end_date.end_of_day)
                            }

  scope :visible, -> { published.where("(starts_at IS NULL or starts_at < ?) and (ends_at IS NULL or ends_at > ?)",
                                               Time.zone.now, Time.zone.now) }
  def product
    person.product
  end

  def reaction_breakdown
    (post_reactions.count > 0) ? post_reactions.group(:reaction).count.sort_by { |r,c| r.to_i(16) }.to_h : nil
  end

  def reactions
    post_reactions
  end

  def reported?
    (post_reports.size > 0) ? "Yes" : "No"
  end

private

  def sensible_dates
    if starts_at.present? && ends_at.present? && starts_at > ends_at
      errors.add(:starts_at, "Cannot start after end!")
    end
  end
end
