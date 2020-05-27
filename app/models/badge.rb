# frozen_string_literal: true
# == Schema Information
#
# Table name: badges
#
#  id                   :bigint(8)        not null, primary key
#  product_id           :integer          not null
#  name_text_old        :text
#  internal_name        :text             not null
#  action_type_id       :integer
#  action_requirement   :integer          default(1), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  point_value          :integer          default(0), not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  description_text_old :text
#  name                 :jsonb            not null
#  description          :jsonb            not null
#  issued_from          :datetime
#  issued_to            :datetime
#

class Badge < ApplicationRecord

  translates :description, :name, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  has_many :badge_awards, dependent: :restrict_with_error
  has_one :reward, -> { where("rewards.reward_type = ?", Reward.reward_types["badge"]) }, foreign_key: "reward_type_id", dependent: :destroy
  has_many :assigned_rewards, through: :reward

  scope :for_product, -> (product) { where( badges: { product_id: product.id } ) }

  has_paper_trail
  acts_as_tenant(:product)

  belongs_to :action_type, counter_cache: true

  # include AttachmentSupport

  has_one_attached :picture

  validates :picture, size: {less_than: 5.megabytes},
            content_type: {in: %w[image/jpeg image/gif image/png]}

  def picture_url
    picture.attached? ? [Rails.application.secrets.cloudfront_url, picture.key].join : nil
  end

  def picture_optimal_url
    opts = { resize: "1000", auto_orient: true, quality: 75}
    picture.attached? ? [Rails.application.secrets.cloudfront_url, picture.variant(opts).processed.key].join : nil
  end

  validate :issued_time_sanity

  normalize_attributes :issued_from, :issued_to

  validates :internal_name,
            presence: { message: _("Internal name is required.") },
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
            length: { in: 3..26, message: _("Internal name must be between 3 and 26 characters.") },
            uniqueness: { scope: :product_id, message: _("There is already a badge with that internal name.") }

  validates :action_requirement, presence: { message: _("Action requirement is required.") },
            numericality: { greater_than: 0, message: _("Action requirement must be greater than zero.") }

  around_create :create_reward
  after_update :update_reward

  def action_count_earned_by(person)
    time_frame_start = (issued_from.present?) ? issued_from : Time.zone.now - 10.years
    time_frame_end = (issued_to.present?) ? issued_to : Time.zone.now + 10.years
    person.badge_actions.where(action_type: action_type).where("created_at >= ?", time_frame_start).where("created_at <= ?", time_frame_end).count
  end

  def current?
    (issued_from.nil? || (Time.zone.now > issued_from)) && (issued_to.nil? || (Time.zone.now < issued_to))
  end

private

  def issued_time_sanity
    if issued_from.present? && issued_to.present? && issued_from > issued_to
      errors.add(:issued_to, :time_sanity, message: _("Issued to cannot be before issued from."))
    end
  end

  def create_reward
    reward = Reward.new(
      status: :active,
      reward_type: :badge,
      product: product,
      internal_name: internal_name,
      points: point_value,
      completion_requirement: action_requirement
    )
    reward.name = name

    if reward.valid? && self.valid?# check if the new reward and badge are valid
      yield # saves the badge
      reward.reward_type_id = id
      reward.save
      AssignedReward.create(reward: reward, assigned: action_type, max_times: 1)
      self.touch
    else
      yield
    end
  end

  def update_reward
    reward = Reward.find_by(reward_type_id: id)

    raise ActiveRecord::RecordNotFound if reward.nil?

    reward.name = name
    reward.save
    reward.update(
      internal_name: internal_name,
      points: point_value,
      completion_requirement: action_requirement
    )
  end
end
