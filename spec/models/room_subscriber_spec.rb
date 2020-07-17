# frozen_string_literal: true

# == Schema Information
#
# Table name: room_subscribers
#
#  id                     :bigint           not null, primary key
#  room_id                :bigint           not null
#  person_id              :bigint           not null
#  last_message_id        :bigint
#  last_notification_time :datetime         not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#


require 'rails_helper'

RSpec.describe RoomSubscriber, type: :model do
  describe '#room_id' do
    it 'does not allow owners to private room' do
      private_room = create(:room, public: false)
      subscriber = private_room.room_subscribers.build(person_id: create(:person).id)
      expect(subscriber).not_to be_valid
      expect(subscriber.errors[:room_id]).not_to be_empty
    end
  end
end
