# frozen_string_literal: true

module JsonHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def badge_json(badge)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/badge_response.json")
    schema = JSONSchemer.schema(schema_path)
    schema.valid?(badge.compact)
  end

  def block_json(block)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/block_response.json")
    schema = JSONSchemer.schema(schema_path)
    schema.valid?(block.compact)
  end

  def event_json(event)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/event_response.json")
    schema = JSONSchemer.schema(schema_path)
    schema.valid?(event.compact)
  end

  def following_json(following, currnt_user = nil)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/following_response.json")
    schema = JSONSchemer.schema(schema_path)
    following['follower'] = following['follower'].compact
    following['followed'] = following['followed'].compact

    schema.valid?(following.compact)
  end

  def level_json(level, lang = nil)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/level_response.json")
    schema = JSONSchemer.schema(schema_path)
    schema.valid?(level.compact)
  end

  def merchandise_json(merchandise)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/merchandise_response.json")
    schema = JSONSchemer.schema(schema_path)
    schema.valid?(merchandise.compact)
  end

  def message_json(msg)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/message_response.json")
    schema = JSONSchemer.schema(schema_path)
    msg['person'] = msg['person'].compact unless msg['person'].nil?
    msg['mentions'] = msg['mentions'].compact unless msg['mentions'].nil?

    schema.valid?(msg.compact)
  end

  def message_list_json(msg)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/message_list_response.json")
    schema = JSONSchemer.schema(schema_path)
    msg['mentions'] = msg['mentions'].compact unless msg['mentions'].nil?

    schema.valid?(msg.compact)
  end

  def message_mentions_json(msg)
    pathname_new = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/mention_response.json")
    schema = JSONSchemer.schema(pathname_new)

    msg['mentions'] = msg['mentions'].compact unless msg['mentions'].nil?

    schema.valid?(msg.compact)
  end

  def message_reports_json(msg_report)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/message_report_response.json")
    schema = JSONSchemer.schema(schema_path)

    schema.valid?(msg_report.compact)
  end

  def pending_badge_json(earned, badge)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/pending_badge_response.json")
    schema = JSONSchemer.schema(schema_path)
    earned['badge'] = earned['badge'].compact
    # puts earned.compact
    # puts "\n Validation: \n"
    # puts schema.validate(earned.compact).to_a
    # puts "\n"
    schema.valid?(earned.compact)
  end

  def person_private_json(person, potential_follower = nil)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_private_response.json")
    schema = JSONSchemer.schema(schema_path)

    schema.valid?(person.compact)
  end

  def person_json(person, potential_follower = nil, lang = nil)
    following = potential_follower ? potential_follower.following_for_person(person) : nil
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_response.json")
    schema = JSONSchemer.schema(schema_path)
    person['following_id'] = following.id if following

    schema.valid?(person.compact)
  end

  def person_share_json(person, potential_follower = nil, lang = nil)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_share_response.json")
    schema = JSONSchemer.schema(schema_path)
    schema.valid?(person.compact)
  end

  def post_comment_json(post_comment)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_comment_response.json")
    schema = JSONSchemer.schema(schema_path)
    post_comment['mentions'] = post_comment['mentions'].compact unless post_comment['mentions'].nil?
    post_comment['person'] = post_comment['person'].compact

    schema.valid?(post_comment.compact)
  end

  def post_comment_list_json(post_comment, lang = nil)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_comment_list_response.json")
    schema = JSONSchemer.schema(schema_path)
    post_comment['mentions'] = post_comment['mentions'].compact unless post_comment['mentions'].nil?

    schema.valid?(post_comment.compact)
  end

  def post_comment_mentions_json(post_comment)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/mention_response.json")
    schema = JSONSchemer.schema(schema_path)

    schema.valid?(post_comment.compact)
  end

  def post_comment_report_json(post_comment_report)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_comment_report_response.json")
    schema = JSONSchemer.schema(schema_path)

    schema.valid?(post_comment_report.compact)
  end

  def post_json(post, lang = nil, reaction = nil)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_response.json")
    schema = JSONSchemer.schema(schema_path)

    post['person'] = post['person'].compact
    post['category'] = post['category'].compact unless post['category'].nil?
    post['tags']&.each do |idx, tag|
      post['tags'][idx] = tag.compact
    end
    post['post_reaction_counts'] = nil # Not easily testable via json schema validation
    post['post_reaction'] = post['post_reaction'].compact unless post['post_reaction'].nil?

    schema.valid?(post.compact)
  end

  def post_share_json(post, lang = nil, reaction = nil)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_share_response.json")
    schema = JSONSchemer.schema(schema_path)
    post['person'] = post['person'].compact

    schema.valid?(post.compact)
  end

  def post_list_json(post, lang = nil)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_list_response.json")
    schema = JSONSchemer.schema(schema_path)
    post['person'] = post['person'].compact
    post['category'] = post['category'].compact unless post['category'].nil?
    post['tags']&.each do |idx, tag|
      post['tags'][idx] = tag.compact
    end

    schema.valid?(post.compact)
  end

  def post_reaction_json(post_reaction)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_reaction_response.json")
    schema = JSONSchemer.schema(schema_path)

    # puts schema.validate(post_reaction.compact).to_a

    schema.valid?(post_reaction.compact)
  end

  def post_report_json(post_report)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_report_response.json")
    schema = JSONSchemer.schema(schema_path)

    # puts schema.validate(post_report.compact).to_a

    schema.valid?(post_report.compact)
  end

  def relationship_json(relationship, currnt_user)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/relationship_response.json")
    schema = JSONSchemer.schema(schema_path)
    relationship['requested_by'] = relationship['requested_by'].compact
    relationship['requested_to'] = relationship['requested_to'].compact
    schema.valid?(relationship.compact)
  end

  def static_content_json(static_content)
    schema_path = Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/static_content.json")
    schema = JSONSchemer.schema(schema_path)

    schema.valid?(static_content.compact)
  end
end
