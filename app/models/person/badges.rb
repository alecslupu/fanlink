class Person
  has_many :badge_actions, dependent: :destroy
  has_many :badge_awards

  has_many :badges, through: :badge_awards

  module Badges
    def badge_points
      badges.sum(:point_value)
    end
  end
end
