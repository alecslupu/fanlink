class Badge < ApplicationRecord
  include AttachmentSupport
  include TranslationThings

  has_manual_translated :description, :name

  has_many :badge_awards, dependent: :restrict_with_error
  has_one :reward, -> { where("rewards.reward_type = ?", Reward.reward_types['badge']) }, :foreign_key => "reward_type_id"
  has_many :assigned_rewards, through: :reward

  has_paper_trail
  acts_as_tenant(:product)

  belongs_to :action_type

  has_image_called :picture

  validate :issued_time_sanity

  normalize_attributes :issued_from, :issued_to

  validates :internal_name,
            presence: true,
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
            length: { in: 3..26 },
            uniqueness: { scope: :product_id, message: "There is already a badge with that internal name." }

  validates :action_requirement, presence: { message: "Action requirement is required." },
            numericality: { greater_than: 0, message: "Action requirement must be greater than zero." }


  def action_count_earned_by(person)
    time_frame_start = (issued_from.present?) ? issued_from : Time.now - 10.years
    time_frame_end = (issued_to.present?) ? issued_to : Time.now + 10.years
    person.badge_actions.where(action_type: action_type).where("created_at >= ?", time_frame_start).where("created_at <= ?", time_frame_end).count
  end

  def current?
    (issued_from.nil? || (Time.zone.now > issued_from)) && (issued_to.nil? || (Time.zone.now < issued_to))
  end

private

  def issued_time_sanity
    if issued_from.present? && issued_to.present? && issued_from > issued_to
      errors.add(:issued_to, "Issued to cannot be before issued from.")
    end
  end
end
