module JsonHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def badge_json(badge)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/badge_app_json.json"))
    b = {  "badge" => badge["badge"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(b)
  end

  def block_json(block)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/block_app_json.json"))
    bl = {  "block" => block["block"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(bl)
  end
  def event_json(event)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/event_app_json.json"))
    ev = {  "event" => person["event"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(ev)
  end
  def following_json(following, currnt_user)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def level_json(level, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/level_app_json.json"))
    
    lv = {  "levels" => person["levels"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(lv)
  end

  def merchandise_json(merchandise)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/merchandise_app_json.json"))
    
    mc = {  "merchandise" => person["merchandise"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(mc)
  end

  def message_json(msg)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/message_app_json.json"))

    message = {  "message" => person["message"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(message)
  end

  def message_list_json(msg)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(msg)
  end

  def message_mentions_json(msg)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def message_reports_json(msg_report)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def message_mentions_json(msg)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def pending_badge_json(earned, badge)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/pending_badge_app_json.json"))
    schema.valid?(badge)
  end

  def person_private_json(person, potential_follower = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_private_app_json.json"))
    user = {  "person" => person["person"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(user)
  end

  def person_json(person, potential_follower = nil, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    user = {  "person" => person["person"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(user)
  end

  def person_share_json(person, potential_follower = nil, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    user = {  "person" => person["person"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(user)
  end
  def post_comment_json(post_comment)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_comment_app_json.json"))
    pc = {  "post_comment" => post_comment["post_comment"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(pc)
  end

  def post_comment_list_json(post_comment, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_comment_app_json.json"))
    pc = {  "post_comment" => post_comment["post_comment"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(pc)
  end

  def post_comment_mentions_json(post_comment)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def post_comment_report_json(post_comment_report)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_comment_report_app_json.json"))
    pcr = {  "post_comment_reports" => post_comment["post_comment_reports"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(pcr)
  end

  def post_json(post, lang = nil, reaction = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/post_app_json.json"))
    pt = {  "post" => post_comment["post"].compact } # Remove nil values since apigen can't handle dual types
    schema.valid?(pt)
  end
  def post_share_json(post, lang = nil, reaction = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def post_list_json(post, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def post_reaction_json(post_reaction)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def post_report_json(post_report)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def post_share_json(post, lang = nil)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end

  def relationship_json(relationship, currnt_user)
    schema = JSONSchemer.schema(Pathname.new("#{Rails.root}/spec/schema/#{@api_version}/person_app_json.json"))
    schema.valid?(person)
  end
end
