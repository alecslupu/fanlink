module JsonHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def badge_json(badge)
    {
      "id"                  => badge.id.to_s,
      "name"                => badge.name,
      "internal_name"       => badge.internal_name,
      "picture_url"         => badge.picture_url,
      "action_requirement"  => badge.action_requirement,
      "point_value"         => badge.point_value
    }
  end

  def following_json(following, currnt_user)
    {
      "id"       => following.id.to_s,
      "follower" => person_profile_json(following.follower, currnt_user),
      "followed" => person_profile_json(following.followed, currnt_user)
    }
  end

  def level_json(level)
    {
        "id"                  => level.id.to_s,
        "name"                => level.name,
        "internal_name"       => level.internal_name,
        "points"              => level.points,
        "picture_url"         => level.picture_url
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

  def pending_badge_json(earned, badge)
    {
      "badge_action_count"  => earned,
      "badge"               => badge_json(badge)
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
  def post_json(post)
    {
      "id"          => post.id.to_s,
      "body"        => post.body,
      "create_time" => post.created_at.to_s,
      "picture_url" => post.picture_id,
      "person" => person_profile_json(post.person)
    }
  end

  def relationship_json(relationship, currnt_user)
    {
      "id"            => relationship.id.to_s,
      "status"        => relationship.status,
      "create_time"   => relationship.created_at.to_s,
      "update_time"   => relationship.updated_at.to_s,
      "requested_by"  => person_profile_json(relationship.requested_by, currnt_user),
      "requested_to"  => person_profile_json(relationship.requested_to, currnt_user)
    }
  end
end
