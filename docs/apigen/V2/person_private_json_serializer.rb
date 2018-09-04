class PersonPrivateJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff246e138 @name="PersonPrivateJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "username"=>{"type"=>"string"}, "name"=>{"type"=>"string"}, "gender"=>{"type"=>"string"}, "city"=>{"type"=>"string"}, "biography"=>{"type"=>"string"}, "country_code"=>{"type"=>"string"}, "birthdate"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}, "product_account"=>{"type"=>"boolean"}, "recommended"=>{"type"=>"boolean"}, "chat_banned"=>{"type"=>"boolean"}, "designation"=>{"type"=>"string"}, "following_id"=>{"type"=>"integer"}, "relationships"=>{"type"=>"array", "items"=>{"type"=>"object", "properties"=>{"relationship"=>{"$ref"=>"#/components/schemas/Relationship"}}}}, "badge_points"=>{"type"=>"integer"}, "role"=>{"type"=>"string"}, "level"=>{"type"=>"string"}, "do_not_message_me"=>{"type"=>"boolean"}, "pin_messages_from"=>{"type"=>"boolean"}, "auto_follow"=>{"type"=>"boolean"}, "num_followers"=>{"type"=>"integer"}, "num_following"=>{"type"=>"integer"}, "facebookid"=>{"type"=>"integer"}, "facebook_picture_url"=>{"type"=>"string"}, "created_at"=>{"type"=>"string", "format"=>"date-time"}, "updated_at"=>{"type"=>"string", "format"=>"date-time"}, "email"=>{"type"=>"string"}, "product"=>{"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "internal_name"=>{"type"=>"string"}}}}, "description"=>"Private Person Response"}>  attributes :id, :username, :name, :gender, :city, :biography, :country_code, :birthdate, :picture_url, :product_account, :recommended, :chat_banned, :designation, :following_id, :relationships, :badge_points, :role, :level, :do_not_message_me, :pin_messages_from, :auto_follow, :num_followers, :num_following, :facebookid, :facebook_picture_url, :created_at, :updated_at, :email, :product


  def id
    type_check(:id, [Integer])
    object.id
  end

  def username
    type_check(:username, [String])
    object.username
  end

  def name
    type_check(:name, [String])
    object.name
  end

  def gender
    type_check(:gender, [String])
    object.gender
  end

  def city
    type_check(:city, [String])
    object.city
  end

  def biography
    type_check(:biography, [String])
    object.biography
  end

  def country_code
    type_check(:country_code, [String])
    object.country_code
  end

  def birthdate
    type_check(:birthdate, [String])
    object.birthdate
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
  end

  def product_account
    type_check(:product_account, [TrueClass, FalseClass])
    object.product_account
  end

  def recommended
    type_check(:recommended, [TrueClass, FalseClass])
    object.recommended
  end

  def chat_banned
    type_check(:chat_banned, [TrueClass, FalseClass])
    object.chat_banned
  end

  def designation
    type_check(:designation, [String])
    object.designation
  end

  def following_id
    type_check(:following_id, [Integer])
    object.following_id
  end

  def relationships
    type_check(:relationships, [Array])
    object.relationships
  end

  def badge_points
    type_check(:badge_points, [Integer])
    object.badge_points
  end

  def role
    type_check(:role, [String])
    object.role
  end

  def level
    type_check(:level, [String])
    object.level
  end

  def do_not_message_me
    type_check(:do_not_message_me, [TrueClass, FalseClass])
    object.do_not_message_me
  end

  def pin_messages_from
    type_check(:pin_messages_from, [TrueClass, FalseClass])
    object.pin_messages_from
  end

  def auto_follow
    type_check(:auto_follow, [TrueClass, FalseClass])
    object.auto_follow
  end

  def num_followers
    type_check(:num_followers, [Integer])
    object.num_followers
  end

  def num_following
    type_check(:num_following, [Integer])
    object.num_following
  end

  def facebookid
    type_check(:facebookid, [Integer])
    object.facebookid
  end

  def facebook_picture_url
    type_check(:facebook_picture_url, [String])
    object.facebook_picture_url
  end

  def created_at
    type_check(:created_at, [String])
    object.created_at
  end

  def updated_at
    type_check(:updated_at, [String])
    object.updated_at
  end

  def email
    type_check(:email, [String])
    object.email
  end

  def product
    type_check(:product, [Hash])
    object.product
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
