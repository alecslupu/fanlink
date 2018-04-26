module JsonHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def badge_json(badge)
    {
      "id"                  => badge.id.to_s,
      "name"                => badge.name,
      "internal_name"       => badge.internal_name,
      "description"         => badge.description,
      "picture_url"         => badge.picture_url,
      "action_requirement"  => badge.action_requirement,
      "point_value"         => badge.point_value
    }
  end

  def block_json(block)
    {
      "id"          => block.id.to_s,
      "blocker_id"  => block.blocker_id,
      "blocked_id"  => block.blocked_id
    }
  end
  def event_json(event)
    {
      "id"          => event.id.to_s,
      "name"        => event.name,
      "description" => event.description,
      "starts_at"   => event.starts_at.to_s,
      "ends_at"     => event.ends_at.to_s,
      "ticket_url"  => event.place_identifier,
      "place_identifier" => event.place_identifier
    }
  end
  def following_json(following, currnt_user)
    {
      "id"       => following.id.to_s,
      "follower" => person_json(following.follower, currnt_user),
      "followed" => person_json(following.followed, currnt_user)
    }
  end

  def level_json(level, lang = nil)
    {
        "id"                  => level.id.to_s,
        "name"                => level.name,
        "internal_name"       => level.internal_name,
        "description"         => (lang.present?) ? level.description(lang) : level.description,
        "points"              => level.points,
        "picture_url"         => level.picture_url
    }
  end

  def merchandise_json(merchandise)
    {
      "id"           => merchandise.id.to_s,
      "name"         => merchandise.name,
      "description"  => merchandise.description,
      "price"        => merchandise.price,
      "purchase_url" => merchandise.purchase_url,
      "picture_url"  => merchandise.picture_url
    }
  end

  def message_json(msg)
    {
      "id"        => msg.id.to_s,
      "body"      => msg.body,
      "create_time" => msg.created_at.to_s,
      "picture_url" => msg.picture_url,
      "person" => person_json(msg.person),
      "mentions" => message_mentions_json(msg)
    }
  end

  def message_list_json(msg)
    {
        "id"        => msg.id.to_s,
        "person_id" => msg.person_id,
        "room_id"   => msg.room_id,
        "body"      => msg.body,
        "hidden"    => msg.hidden,
        "picture_url" => msg.picture_url,
        "created_at" => msg.created_at.to_s,
        "updated_at" => msg.updated_at.to_s
    }
  end

  def message_mentions_json(msg)
    if msg.mentions.count > 0
      mentions = []
      msg.mentions.each do |m|
        mentions << { person_id: m.person_id, linked_text: m.linked_text }
      end
      mentions
    else
      nil
    end
  end
  def message_reports_json(msg_report)
    {
        "id"          => msg_report.id.to_s,
        "created_at"  => msg_report.created_at.to_s,
        "updated_at"  => msg_report.updated_at.to_s,
        "message_id"  => msg_report.message_id,
        "poster"      => msg_report.message.person.username,
        "reporter"    => msg_report.person.username,
        "reason"      => msg_report.reason,
        "status"      => msg_report.status
    }
  end

  def pending_badge_json(earned, badge)
    {
      "badge_action_count"  => earned,
      "badge"               => badge_json(badge)
    }
  end

  def person_private_json(person, potential_follower = nil)
    person_json(person, potential_follower).merge(
      "email" => person.email
    )
  end

  def person_json(person, potential_follower = nil, lang = nil)
    following = (potential_follower) ? potential_follower.following_for_person(person) : nil
    {
      "id"                => person.id.to_s,
      "username"          => person.username,
      "name"              => person.name,
      "gender"            => person.gender,
      "city"              => person.city,
      "country_code"      => person.country_code,
      "birthdate"         => (person.birthdate.present?) ? person.birthdate.to_s : nil,
      "picture_url"       => person.picture_url,
      "product_account"   => person.product_account,
      "recommended"       => person.recommended,
      "chat_banned"       => person.chat_banned,
      "designation"       => (lang.present?) ? person.designation(lang) : person.designation,
      "following_id"      => (following) ? following.id : nil,
      "num_followers"     => person.followers.count,
      "num_following"     => person.following.count,
      "badge_points"      => person.badge_points,
      "role"              => person.role,
      "level"             => (person.level.nil?) ? nil : level_json(person.level),
      "do_not_message_me" => person.do_not_message_me,
      "pin_messages_from" => person.pin_messages_from,
      "auto_follow"       => person.auto_follow,
      "facebookid"        => person.facebookid,
      "facebook_picture_url" => person.facebook_picture_url,
      "created_at"        => person.created_at.to_s,
      "updated_at"        => person.updated_at.to_s
    }
  end
  def post_json(post, lang = nil, reaction = nil)
    {
      "id"          => post.id.to_s,
      "body"        => (lang.present?) ? post.body(lang) : post.body,
      "create_time" => post.created_at.to_s,
      "picture_url" => post.picture_url,
      "person" => person_json(post.person),
      "post_reaction_counts" => post.reaction_breakdown.to_json,
      "post_reaction" => (reaction.nil?) ? nil : post_reaction_json(reaction),
      "recommended"   => post.recommended
    }
  end
  def post_list_json(post, lang = nil)
    {
      "id"              => post.id.to_s,
      "person_id"       => post.person_id,
      "body"            => (lang.present?) ? post.body(lang) : post.body,
      "picture_url"     =>  post.picture_url,
      "global"          => post.global,
      "starts_at"       => post.starts_at.to_s,
      "ends_at"         => post.ends_at.to_s,
      "repost_interval" => post.repost_interval,
      "status"          => post.status,
      "priority"        => post.priority,
      "recommended"     => post.recommended,
      "created_at"      => post.created_at.to_s,
      "updated_at"      => post.updated_at.to_s
    }
  end

  def post_reaction_json(post_reaction)
    {
      "id"        => post_reaction.id.to_s,
      "post_id"   => post_reaction.post_id,
      "person_id" => post_reaction.person_id,
      "reaction"  => post_reaction.reaction
    }
  end

  def post_report_json(post_report)
    {
        "id"          => post_report.id.to_s,
        "created_at"  => post_report.created_at.to_s,
        "post_id"     => post_report.post_id,
        "poster"      => post_report.post.person.username,
        "reporter"    => post_report.person.username,
        "reason"      => post_report.reason,
        "status"      => post_report.status
    }
  end

  def post_share_json(post, lang = nil)
    {
      "body"        => (lang.present?) ? post.body(lang) : post.body,
      "picture_url" => post.picture_url,
      "person" => { "username" => post.person.username,
                    "picture_url" => post.person.picture_url }
    }
  end

  def relationship_json(relationship, currnt_user)
    {
      "id"            => relationship.id.to_s,
      "status"        => relationship.status,
      "create_time"   => relationship.created_at.to_s,
      "update_time"   => relationship.updated_at.to_s,
      "requested_by"  => person_json(relationship.requested_by, currnt_user),
      "requested_to"  => person_json(relationship.requested_to, currnt_user)
    }
  end
end
