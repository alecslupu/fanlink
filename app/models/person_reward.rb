# frozen_string_literal: true
# == Schema Information
#
# Table name: person_rewards
#
#  id         :bigint(8)        not null, primary key
#  person_id  :integer          not null
#  reward_id  :integer          not null
#  source     :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted    :boolean          default(FALSE)
#

class PersonReward < ApplicationRecord
  belongs_to :reward
  belongs_to :person, touch: true
end
