class MigrateRoomTranslationData < ActiveRecord::Migration[5.2]
  def up
    if Room.last.respond_to?(:untranslated_name)
      Room::Translation.destroy_all
      Room.where.not(untranslated_name: nil).find_each do |room|
        Migration::RoomJob.set(wait_until: 30.minutes.from_now).perform_later(room.id)
      end
    end
  end
  def down

  end
end
