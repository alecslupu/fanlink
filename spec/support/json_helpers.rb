module JsonHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def following_json(following, currnt_user)
    {
      "id"       => following.id.to_s,
      "follower" => person_profile_json(following.follower, currnt_user),
      "followed" => person_profile_json(following.followed, currnt_user)
    }
  end

  def message_json(msg)
    {
      "id"        => msg.id.to_s,
      "body"      => msg.body,
      "create_time" => msg.created_at.to_s,
      "picture_url" => msg.picture_id,
      "person" => person_profile_json(msg.person)
    }
  end

  def person_private_json(person, potential_follower = nil)
    person_profile_json(person, potential_follower).merge(
      "email" => person.email
    ).except("following_id")
  end

  def person_profile_json(person, potential_follower = nil)
    following = (potential_follower) ? potential_follower.following_for_person(person) : nil
    {
      "id"           => person.id.to_s,
      "username"     => person.username,
      "name"         => person.name,
      "picture_url"  => person.picture_url,
      "following_id" => (following) ? following.id : nil
    }
  end
end
