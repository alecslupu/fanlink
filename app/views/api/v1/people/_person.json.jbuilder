json.id person.id.to_s
json.(person, :username, :name, :picture_url, :product_account, :recommended, :chat_banned)
if fol = current_user && current_user.following_for_person(person)
  json.following_id fol.id
else
  json.following_id nil
end
if defined?(relationships) && !relationships.empty?
  json.relationships relationships, partial: "api/v1/relationships/relationship", as: :relationship
end
json.badge_points person.badge_points
lev = person.level_earned
if lev.nil?
  json.level nil
else
  json.level lev, partial: "api/v1/levels/level", as: :level
end
json.do_not_message_me person.do_not_message_me
json.pin_messages_from person.pin_messages_from
