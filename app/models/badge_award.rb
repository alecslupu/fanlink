# == Schema Information
#
# Table name: badge_awards
#
#  id         :bigint(8)        not null, primary key
#  person_id  :integer          not null
#  badge_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BadgeAward < ApplicationRecord
  belongs_to :badge
  belongs_to :person, touch: true

  validate :product_match

  # returns hash :badge => points_achieved if no badge earned
  # else returns array of badges earned
  def self.award_badges(badge_action)
    badge_awards = []
    badge_pending = {}
    best_perc = 0.0
    already_earned = badge_action.person.badges
    badge_action.action_type.badges.each do |b|
      next if already_earned.include?(b) || !b.current?
      achieved = b.action_count_earned_by(badge_action.person)
      required = b.action_requirement
      if achieved >= required
        create(person: badge_action.person, badge: b)
        badge_awards << b
      end
      if badge_awards.empty?
        perc = (achieved * 1.0) / b.action_requirement
        if perc > best_perc
          best_perc = perc
          badge_pending.clear
          badge_pending[b] = achieved
        end
      end
    end
    (badge_awards.empty?) ? badge_pending : badge_awards
  end

  private

    def product_match
      if badge.product_id != person.product_id
        errors.add(:base, :product_mismatch, message: _("Product mismatch!"))
      end
    end
end
