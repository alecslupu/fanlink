# == Schema Information
#
# Table name: pin_messages
#
#  id         :bigint(8)        not null, primary key
#  person_id  :integer          not null
#  room_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PinMessage < ApplicationRecord
  belongs_to :person, touch: true
  belongs_to :room, touch: true
end
