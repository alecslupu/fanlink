json.cache! ["v3", person],  expires_in: 20.minutes do
  json.id person.id.to_s
  json.(person, :username, :name, :gender, :city, :country_code, :birthdate, :biography, :picture_url, :product_account, :recommended, :chat_banned, :tester)
  json.designation person.designation(@lang)

  json.role person.role
  json.do_not_message_me person.do_not_message_me
  json.pin_messages_from person.pin_messages_from
  json.auto_follow person.auto_follow
  json.num_followers person.followers.count
  json.num_following person.following.count
  json.facebookid person.facebookid
  json.facebook_picture_url person.facebook_picture_url
  json.created_at person.created_at.to_s
  json.updated_at person.updated_at.to_s
end
if person.level_progresses.present?
  json.badge_points person.level_progresses.first.total
else
  json.badge_points 0
end
lev = person.level_earned
if lev.nil?
  json.level nil
else
  json.level lev, partial: "api/v4/levels/level", as: :level
end
if fol = current_user && current_user.following_for_person(person)
  json.following_id fol.id
else
  json.following_id nil
end
if defined?(relationships) && !relationships.empty?
  json.relationships relationships, partial: "api/v4/relationships/relationship", as: :relationship
end
