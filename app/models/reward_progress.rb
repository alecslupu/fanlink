# frozen_string_literal: true
# == Schema Information
#
# Table name: reward_progresses
#
#  id         :bigint(8)        not null, primary key
#  reward_id  :integer          not null
#  person_id  :integer          not null
#  series     :text
#  actions    :jsonb            not null
#  total      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RewardProgress < ApplicationRecord
  belongs_to :person, touch: true
  belongs_to :reward

  normalize_attributes :series
end
