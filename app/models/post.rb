class Post < ApplicationRecord
  include AttachmentSupport
  include Post::PortalFilters
  include Post::RealTime
  include TranslationThings

  enum status: %i[ pending published deleted rejected errored ]

  after_save :adjust_priorities

  has_manual_translated :body

  has_image_called :picture
  has_audio_called :audio
  has_paper_trail

  has_many :post_tags
  has_many :tags, through: :post_tags

  has_many :post_comments, dependent: :destroy
  has_many :post_reports, dependent: :destroy
  has_many :post_reactions

  belongs_to :person, touch: true
  belongs_to :category, optional: true

  normalize_attributes :starts_at, :ends_at

  validate :sensible_dates

  scope :following_and_own, -> (follower) { includes(:person).where(person: follower.following + [follower]) }

  scope :for_person, -> (person) { includes(:person).where(person: person) }
  scope :for_product, -> (product) { joins(:person).where("people.product_id = ?", product.id) }
  scope :in_date_range, -> (start_date, end_date) {
          where("posts.created_at >= ? and posts.created_at <= ?",
                start_date.beginning_of_day, end_date.end_of_day)
        }
  scope :for_tag, -> (tag) { joins(:tags).where("tags.name = ?", tag) }
  scope :for_category, -> (categories) { joins(:category).where("categories.name IN (?)", categories) }
  scope :unblocked, -> (blocked_users) { where.not(person_id: blocked_users) }
  scope :visible, -> {
          published.where("(starts_at IS NULL or starts_at < ?) and (ends_at IS NULL or ends_at > ?)",
                          Time.zone.now, Time.zone.now)
        }

  def cache_key
    [super, person.cache_key].join("/")
  end

  def comments
    post_comments
  end

  def product
    person.product
  end

  def reaction_breakdown
    (post_reactions.count > 0) ? post_reactions.group(:reaction).count.sort_by { |r, c| r.to_i(16) }.to_h : nil
  end

  def reactions
    post_reactions
  end

  def reported?
    (post_reports.size > 0) ? "Yes" : "No"
  end

  def visible?
    (status == "published" && ((starts_at == nil || starts_at <  Time.zone.now) && (ends_at == nil || ends_at > Time.zone.now))) ? self : nil
  end

  private

    def adjust_priorities
      if priority > 0 && saved_change_to_attribute?(:priority)
        same_priority = person.posts.where.not(id: self.id).where(priority: self.priority)
        if same_priority.count > 0
          person.posts.where.not(id: self.id).where("priority >= ?", self.priority).each do |p|
            p.increment!(:priority)
          end
        end
      end
    end

    def sensible_dates
      if starts_at.present? && ends_at.present? && starts_at > ends_at
        errors.add(:starts_at, "Cannot start after end!")
      end
    end
end
