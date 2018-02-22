class ActionType < ApplicationRecord
  default_scope { where(active: true) }
  has_many :badges #all badges that implement this type

  has_paper_trail

  before_destroy :check_usage

  validates :internal_name,
            presence: true,
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
            length: { in: 3..26 },
            uniqueness: { message: "There is already an action type with that internal name." }

  validates :name,
            presence: true,
            length: { in: 3..36 },
            uniqueness: { message: "There is already an action type with that name." }

private

  def check_usage
    badge = Badge.where(action_type_id: self.id).first
    if badge
      errors.add(:base, "You cannot destroy this action type because badge named: '#{badge.name}' is using it.")
      throw :abort
    end
  end
end
