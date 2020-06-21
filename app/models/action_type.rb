# frozen_string_literal: true

# == Schema Information
#
# Table name: action_types
#
#  id                  :bigint(8)        not null, primary key
#  name                :text             not null
#  internal_name       :text             not null
#  seconds_lag         :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  active              :boolean          default(TRUE), not null
#  badge_actions_count :integer
#  badges_count        :integer
#

class ActionType < ApplicationRecord
  has_many :badges, dependent: :restrict_with_error
  has_many :assigned_rewards, as: :assigned
  has_many :rewards, through: :assigned_rewards, source: :assigned, source_type: "ActionType"
  has_many :badge_actions, dependent: :restrict_with_error

  has_many :hacked_metrics, dependent: :destroy

  has_paper_trail ignore: [:created_at, :updated_at]

  # before_destroy :check_usage

  validates :internal_name,
            presence: { message: _("Internal name is required.") },
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
            length: { in: 3..26, message: _("Internal name must be between 3 and 26 characters.") },
            uniqueness: { message: _("There is already an action type with that internal name.") }

  validates :name,
            presence: { message: _("Name is required.") },
            length: { in: 3..36, message: _("Name must be between 3 and 36 characters.") },
            uniqueness: { message: _("There is already an action type with that name.") }

  def in_use?
    badge_actions.size > 0 || badges.size > 0
  end
end
