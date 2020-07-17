# frozen_string_literal: true

# == Schema Information
#
# Table name: badge_actions
#
#  id             :bigint           not null, primary key
#  action_type_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  identifier     :text
#

class BadgeAction < ApplicationRecord
  belongs_to :action_type, counter_cache: true
  belongs_to :person, touch: true

  normalize_attributes :identifier

  validates :identifier, uniqueness: { scope: %i[person_id action_type_id],
                                       message: _('Sorry, you cannot get credit for that action again.') }, allow_nil: true
end
