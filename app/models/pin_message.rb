# frozen_string_literal: true

# == Schema Information
#
# Table name: pin_messages
#
#  id         :bigint           not null, primary key
#  person_id  :integer          not null
#  room_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PinMessage < ApplicationRecord
  belongs_to :person
  belongs_to :room
end
