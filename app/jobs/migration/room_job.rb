class Migration::RoomJob < ApplicationJob
  queue_as :migration

  def perform(room_id)
    langs = ["en", "es", "ro"]
    room = Room.find(room_id)

    langs.each do |value|
      next if room.untranslated_name[value].nil?
      next if room.untranslated_name[value].empty?
      next if room.untranslated_name[value] == '-'

      I18n.locale = value
      room.name = room.untranslated_name[value]
      room.description = room.untranslated_description[value]
      room.save!
    end
    unless Room.with_translations('en').where(id: room.id).first.present?
      next if room.untranslated_name["un"].nil?
      next if room.untranslated_name["un"].empty?
      I18n.locale = "en"
      room.name = room.untranslated_name["un"]
      room.description = room.untranslated_description["un"]
      room.save!
    end
  end
end
