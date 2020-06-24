# frozen_string_literal: true

# == Schema Information
#
# Table name: quests
#
#  id                   :bigint(8)        not null, primary key
#  product_id           :integer          not null
#  event_id             :integer
#  name_text_old        :text
#  internal_name        :text             not null
#  description_text_old :text
#  status               :integer          default("active"), not null
#  starts_at            :datetime         not null
#  ends_at              :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  picture_meta         :text
#  name                 :jsonb            not null
#  description          :jsonb            not null
#  reward_id            :integer
#

class Quest < ApplicationRecord
  # include Quest::PortalFilters
  scope :id_filter, ->(query) { where(id: query.to_i) }
  scope :product_id_filter, ->(query) { where(product_id: query.to_i) }
  scope :product_filter, ->(query) { joins(:product).where('product.internal_name ilike ? or product.name ilike ?', "%#{query}%", "%#{query}%") }
  scope :name_filter, ->(query) { where("quests.name->>'en' ilike ? or quests.name->>'un' ilike ?", "%#{query}%", "%#{query}%") }
  scope :description_filter, ->(query) { where("quests.description->>'en' ilike ? or quests.descriptions->>'un' ilike ?", "%#{query}%", "%#{query}%") }
  scope :starts_at_filter, ->(query) { where('quests.starts_at >= ?', Time.zone.parse(query)) }
  scope :ends_at_filter, ->(query) { where('quests.ends_at <= ?', Time.zone.parse(query)) }
  scope :posted_after_filter, ->(query) { where('quests.created_at >= ?', Time.zone.parse(query)) }
  scope :posted_before_filter, ->(query) { where('quests.created_at <= ?', Time.zone.parse(query)) }
  scope :status_filter, ->(query) { where(status: query.to_sym) }
  # include Quest::PortalFilters

  # enum status: %i[ in_development in_testing published deleted ]
  enum status: %i[disabled enabled active deleted]

  acts_as_tenant(:product)
  belongs_to :product

  scope :for_product, ->(product) { where(quests: { product_id: product.id }) }

  has_one_attached :picture

  validates :picture, size: { less_than: 5.megabytes },
                      content_type: { in: %w[image/jpeg image/gif image/png] }

  def picture_url
    picture.attached? ? [Rails.application.secrets.cloudfront_url, picture.key].join('/') : nil
  end

  def picture_optimal_url
    opts = { resize: '1000', auto_orient: true, quality: 75 }
    picture.attached? ? [Rails.application.secrets.cloudfront_url, picture.variant(opts).processed.key].join('/') : nil
  end

  def picture_width
    picture.attached? ? picture.blob.metadata[:width] : nil
  end

  def picture_height
    picture.attached? ? picture.blob.metadata[:height] : nil
  end

  translates :description, :name, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  has_many :assigned_rewards, as: :assigned

  has_many :rewards, through: :assigned_rewards # , source: :assigned, source_type: "Quest"

  has_many :steps, -> { order(created_at: :asc) }, dependent: :destroy, inverse_of: :quest
  #   has_many :quest_completions, dependent: :destroy

  accepts_nested_attributes_for :steps

  normalize_attributes :event_id, :ends_at

  has_paper_trail ignore: [:created_at, :updated_at]

  validate :date_sanity
  validates_associated :translations

  validates :name, presence: { message: _('Name is required.') }
  validates :description, presence: { message: _('A quest description is required.') }

  validates :starts_at, presence: { message: _('Starting date and time is required.') }

  scope :in_date_range, ->(start_date, end_date) {
                          where('quests.starts_at >= ? and quests.ends_at <= ?',
                                start_date.beginning_of_day, end_date.end_of_day)
                        }
  scope :ordered, -> { includes(:quest_activities).order('quest_activities.created_at DESC') }
  scope :for_product, ->(product) { includes(:product).where(product: product) }
  scope :in_testing, -> { where(status: [:enabled, :active]) }
  scope :running, -> { where('quests.starts_at >= ? AND quests.ends_at <= ?', Time.zone.now, Time.zone.now) }

  def running?
    starts_at >= Time.zone.now && (ends_at.nil? || ends_at <= Time.zone.now)
  end

  private

  def date_sanity
    if ends_at.present? && ends_at < starts_at
      errors.add(:ends_at, :date_sanity, message: _('Start date cannot be after end date.'))
    end
  end
end
