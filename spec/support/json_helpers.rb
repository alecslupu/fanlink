module JsonHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def badge_json(badge)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/badge_response.json"))

    # puts schema.validate(badge.compact).to_a

    schema.valid?(badge.compact)
  end

  def block_json(block)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/block_response.json"))

    # puts schema.validate(block.compact).to_a

    schema.valid?(block.compact)
  end
  def event_json(event)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/event_response.json"))

    # puts schema.validate(event.compact).to_a

    schema.valid?(event.compact)
  end
  def following_json(following, currnt_user)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/following_response.json"))
    
    # puts schema.validate(following.compact).to_a

    schema.valid?(following.compact)
  end

  def level_json(level, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/level_response.json"))

    # puts schema.validate(level.compact).to_a

    schema.valid?(level.compact)
  end

  def merchandise_json(merchandise)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/merchandise_response.json"))

    # puts schema.validate(merchandise.compact).to_a

    schema.valid?(merchandise.compact)
  end

  def message_json(msg)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/message_response.json"))

    msg["mentions"] = msg["mentions"].compact unless msg["mentions"].nil?

    schema.valid?(msg.compact)
  end

  def message_list_json(msg)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/message_list_response.json"))

    msg["mentions"] = msg["mentions"].compact unless msg["mentions"].nil?

    schema.valid?(msg.compact)
  end

  def message_mentions_json(msg)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/mention_response.json"))

    msg["mentions"] = msg["mentions"].compact unless msg["mentions"].nil?

    schema.valid?(msg.compact)
  end

  def message_reports_json(msg_report)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/message_report_response.json"))

    # puts schema.validate(msg_report.compact).to_a

    schema.valid?(msg_report.compact)
  end

  def pending_badge_json(earned, badge)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/pending_badge_response.json"))

    # puts schema.validate(earned.compact).to_a

    schema.valid?(badge.compact)
  end

  def person_private_json(person, potential_follower = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_private_response.json"))

    # puts schema.validate(person.compact).to_a

    schema.valid?(person.compact)
  end

  def person_json(person, potential_follower = nil, lang = nil)
    following = (potential_follower) ? potential_follower.following_for_person(person) : nil
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_response.json"))
    person["following_id"] = following.id if following

    # puts schema.validate(person.compact).to_a

    schema.valid?(person.compact)
  end

  def person_share_json(person, potential_follower = nil, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_share_response.json"))

    # puts schema.validate(person.compact).to_a

    schema.valid?(person.compact)
  end
  def post_comment_json(post_comment)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_comment_response.json"))
    post_comment["mentions"] = post_comment["mentions"].compact unless post_comment["mentions"].nil?
    post_comment["person"] = post_comment["person"].compact

    puts "\n Validation: \n"
    puts schema.validate(post_comment.compact).to_a
    puts "\n"

    schema.valid?(post_comment.compact)
  end

  def post_comment_list_json(post_comment, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_comment_list_response.json"))
    post_comment["mentions"] = post_comment["mentions"].compact unless post_comment["mentions"].nil?

    schema.valid?(post_comment.compact)
  end

  def post_comment_mentions_json(post_comment)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/mention_response.json"))

    schema.valid?(post_comment.compact)
  end

  def post_comment_report_json(post_comment_report)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_comment_report_response.json"))

    schema.valid?(post_comment_report.compact)
  end

  def post_json(post, lang = nil, reaction = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_response.json"))

    post["person"] = post["person"].compact
    post["category"] = post["category"].compact unless post["category"].nil?
    post["tags"].each do |idx, tag|
      post["tags"][idx] = tag.compact
    end unless post["tags"].nil?
    post["post_reaction_counts"] = nil #Not easily testable via json schema validation
    post["post_reaction"] = post["post_reaction"].compact unless  post["post_reaction"].nil?
 
    schema.valid?(post.compact)
  end

  def post_share_json(post, lang = nil, reaction = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_share_response.json"))
    post["person"] = post["person"].compact

    schema.valid?(post.compact)
  end

  def post_list_json(post, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_list_response.json"))
    post["person"] = post["person"].compact
    post["category"] = post["category"].compact unless post["category"].nil?
    post["tags"].each do |idx, tag|
      post["tags"][idx] = tag.compact
    end unless post["tags"].nil?

    schema.valid?(post.compact)
  end

  def post_reaction_json(post_reaction)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_reaction_response.json"))

    # puts schema.validate(post_reaction.compact).to_a

    schema.valid?(post_reaction.compact)
  end

  def post_report_json(post_report)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_report_response.json"))

    # puts schema.validate(post_report.compact).to_a
    
    schema.valid?(post_report.compact)
  end

  def relationship_json(relationship, currnt_user)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/relationship_response.json"))
    relationship["requested_by"] = relationship["requested_by"].compact
    relationship["requested_to"] = relationship["requested_to"].compact
    schema.valid?(relationship.compact)
  end
end
