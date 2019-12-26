# == Schema Information
#
# Table name: posts
#
#  id                   :bigint(8)        not null, primary key
#  person_id            :integer          not null
#  body_text_old        :text
#  global               :boolean          default(FALSE), not null
#  starts_at            :datetime
#  ends_at              :datetime
#  repost_interval      :integer          default(0), not null
#  status               :integer          default("pending"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  body                 :jsonb            not null
#  priority             :integer          default(0), not null
#  recommended          :boolean          default(FALSE), not null
#  notify_followers     :boolean          default(FALSE), not null
#  audio_file_name      :string
#  audio_content_type   :string
#  audio_file_size      :integer
#  audio_updated_at     :datetime
#  category_id          :integer
#  video_file_name      :string
#  video_content_type   :string
#  video_file_size      :integer
#  video_updated_at     :datetime
#  video_job_id         :string
#  video_transcoded     :jsonb            not null
#  post_comments_count  :integer          default(0)
#  pinned               :boolean          default(FALSE)
#

class Post < ApplicationRecord
  include AttachmentSupport
  # include Post::PortalFilters

  scope :id_filter, -> (query) { where(id: query.to_i) }
  scope :person_id_filter, -> (query) { where(person_id: query.to_i) }
  scope :person_filter, -> (query) { joins(:person).where("people.username_canonical ilike ? or people.email ilike ?", "%#{query}%", "%#{query}%") }
  scope :body_filter, -> (query) { where("posts.body->>'en' ilike ? or posts.body->>'un' ilike ?", "%#{query}%", "%#{query}%") }
  scope :posted_after_filter, -> (query) { where("posts.created_at >= ?", Time.parse(query)) }
  scope :posted_before_filter, -> (query) { where("posts.created_at <= ?", Time.parse(query)) }
  scope :status_filter, -> (query) { where(status: query.to_sym) }
  # include Post::PortalFilters
  include TranslationThings

  #   include Post::RealTime

  def delete_real_time(version = 0)
    Delayed::Job.enqueue(DeletePostJob.new(self.id, version))
  end

  def post(version = 0)
    Delayed::Job.enqueue(PostPostJob.new(self.id, version))
    if notify_followers && (person.followers.count > 0)
      Delayed::Job.enqueue(PostPushNotificationJob.new(self.id))
    end
  end
  #   include Post::RealTime
  enum status: %i[ pending published deleted rejected errored ]

  after_save :adjust_priorities

  has_manual_translated :body

  has_image_called :picture
  has_audio_called :audio
  has_video_called :video

  has_paper_trail

  has_many :post_tags
  has_many :tags, through: :post_tags

  has_many :post_comments, dependent: :destroy
  has_many :post_reports, dependent: :destroy
  has_many :post_reactions

  has_one :poll, -> { where("polls.poll_type = ?", Poll.poll_types["post"]) }, foreign_key: "poll_type_id", dependent: :destroy
  has_many :poll_options, through: :poll

  belongs_to :person, touch: true
  belongs_to :category, optional: true

  after_commit :flush_cache

  normalize_attributes :starts_at, :ends_at

  validate :sensible_dates

  after_create :start_transcoding, if: :video_file_name

  after_save :expire_cache
  before_destroy :expire_cache, prepend: true

  scope :following_and_own, -> (follower) { includes(:person).where(person: follower.following + [follower]) }

  scope :promoted, -> {
          left_outer_joins(:poll).where("(polls.poll_type = ? and polls.end_date > ? and polls.start_date < ?) or pinned = true or global = true", Poll.poll_types["post"], Time.now, Time.now)
        }

  scope :for_person, -> (person) { includes(:person).where(person: person) }
  scope :for_product, -> (product) { joins(:person).where("people.product_id = ?", product.id) }
  scope :in_date_range, -> (start_date, end_date) {
          where("posts.created_at >= ? and posts.created_at <= ?",
                start_date.beginning_of_day, end_date.end_of_day)
        }
  scope :for_tag, -> (tag) { joins(:tags).where("lower(tags.name) = ?", tag.downcase) }
  scope :for_category, -> (categories) { joins(:category).where("categories.name IN (?)", categories) }
  scope :unblocked, -> (blocked_users) { where.not(person_id: blocked_users) }
  scope :visible, -> {
          published.where("(starts_at IS NULL or starts_at < ?) and (ends_at IS NULL or ends_at > ?)",
                          Time.zone.now, Time.zone.now)
        }
  scope :not_promoted, -> {
          left_joins(:poll).where("poll_type_id IS NULL or end_date < NOW()")
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

  def cached_person
    Person.cached_find(person_id)
  end

  #
  # def self.cached_for_person(person)
  #   Rails.cache.fetch([name, person]) {
  #     for_person(person)
  #   }
  # end

  def self.cached_for_product(product)
    Rails.cache.fetch([name, product]) {
      for_product(product)
    }
  end

  #
  # Process an Elastic Transcoder response notification.
  #
  # @param [Hash] msg
  #   The unpacked JSON message.
  #
  def self.process_et_response(msg)
    #
    # We assume that the post has been deleted if we can't find it.
    #
    raise msg.inspect if (msg["state"] != "COMPLETED")
    post = self.find_by(:id => msg["userMetadata"]["post_id"].to_i)
    return unless post.present?

    if (msg["userMetadata"]["sizer"])
      # There should be exactly one entry in `outputs`.
      width, height = msg["outputs"][0].values_at("width", "height").map(&:to_i)
      job = Flaws.finish_transcoding(post.video.path,
                                     width, height,
                                     post_id: post.id.to_s)
      post.video_job_id = job.id
      post.save!
      post.send(:start_listener)
    else
      presets = ([msg["userMetadata"]["presets"]] + msg["outputs"].to_a.map { |output| output["presetId"] }).compact
      post.send(:youve_been_transcoded!, presets)
    end
  end

  def video_thumbnail
    return if video_transcoded.empty?
    id = File.basename(self.video.path, File.extname(self.video.path))
    url = "#{self.video.s3_bucket.url}/thumbnails/#{id}-00001.jpg"
  end

  def flush_cache
    Rails.cache.delete([self.class.name, product])
  end

  def reaction_breakdown
    (post_reactions.count > 0) ? PostReaction.group_reactions(self).sort_by { |reaction, index| reaction.to_i(16) }.to_h : nil
  end

  # def reaction_breakdown
  #   Rails.cache.fetch([cache_key, __method__]) {
  #     (cached_reaction_count > 0) ? PostReaction.group_reactions(self).sort_by { |reaction, index| reaction.to_i(16) }.to_h : nil
  #   }
  # end

  # def cached_reaction_count
  #   Rails.cache.fetch([cache_key, __method__]) { post_reactions.count }
  # end

  def cached_tags
    Rails.cache.fetch([self, "tags"]) { tags }
  end

  def reactions
    Rails.cache.fetch([self, "post_reactions"]) { post_reactions }
  end

  def reported?
    (post_reports.size > 0) ? "Yes" : "No"
  end

  def visible?
    (status == "published" && ((starts_at == nil || starts_at < Time.zone.now) && (ends_at == nil || ends_at > Time.zone.now))) ? self : nil
  end

  def start_listener
    return if (!Flaws.transcoding_queue?)
    Rails.logger.error("Listening to #{self.video_job_id}")
    Delayed::Job.enqueue(PostQueueListenerJob.new(self.video_job_id), run_at: 30.seconds.from_now)
  end

  def published?
    status == "published" && ((starts_at == nil || starts_at < Time.zone.now) && (ends_at == nil || ends_at > Time.zone.now)) && poll == nil
  end

  private

  def start_transcoding
    # return if(self.video_transcoded? || self.video_job_id || Rails.env.test?)
    return if (self.video_job_id || Rails.env.test?)
    Delayed::Job.enqueue(PostTranscoderJob.new(self.id), run_at: 1.minutes.from_now)
    true
  end

  def merge_new_videos(new_videos)
    by_src = -> (e) { e[:src] }
    by_m3u8 = -> (e) { e[:src].to_s.end_with?("v.m3u8") }

    m3u8, the_rest = (self.video_transcoded.to_a + new_videos).uniq(&by_src).partition(&by_m3u8)
    m3u8 + the_rest.sort_by(&by_src)
  end

  #
  # Mark this video as having been transcoded. The SQS DJ and SNS
  # listener use this to tell the Post that it is all finished.
  #
  def youve_been_transcoded!(preset_ids)
    self.video_transcoded = merge_new_videos(Flaws.transcoded_summary_for(self.video.path, preset_ids))
    self.video_job_id = nil
    self.save!
  end

  def adjust_priorities
    if priority > 0 && saved_change_to_attribute?(:priority)
      same_priority = person.posts.where.not(id: self.id).where(priority: self.priority)
      if same_priority.count > 0
        person.posts.where.not(id: self.id).where("priority >= ?", self.priority).each do |post|
          post.increment!(:priority)
        end
      end
    end
  end

  def sensible_dates
    if starts_at.present? && ends_at.present? && starts_at > ends_at
      errors.add(:starts_at, :sensible_dates, message: _("Start date cannot be after end date."))
    end
  end

  def expire_cache
    ActionController::Base.expire_page(Rails.application.routes.url_helpers.cache_post_path(post_id: self.id, product: product.internal_name))
  end
end
