FanlinkApi::API.model :person_app_json do
  type :object do
    person :object do
      id :string?
      username :string?
      name :string?
      created_at :string?
      updated_at :string?
      facebookid :string?
      facebook_picture_url :string?
      picture_url :string?
      num_followers :int32?
      num_followings :int32?
      following_id :int32?
      level :object do
        type :level_app_json
      end
      badge_points :int32?
      do_not_message_me :bool?
      pin_messages_from :bool?
      auto_follow :bool?
      role :enum? do
        value "normal"
        value "staff"
        value "admin"
        value "super_admin"
      end
      product_account :bool?
      chat_banned :bool?
      designation :string?
      recommended :bool?
      gender :enum? do
        value "male"
        value "female"
        value "unspecified"
      end
      birthdate :string?
      city :string?
      country_code :string?
      biography :string?
    end
  end
end


FanlinkApi::API.model :person_private_app_json do
  type :object do
    person :object do
      id :string?
      username :string?
      email :string?
      name :string?
      created_at :string?
      updated_at :string?
      facebookid :string?
      facebook_picture_url :string?
      picture_url :string?
      num_followers :int32?
      num_followings :int32?
      following_id :int32?
      level :object? do
        type :level_app_json
      end
      badge_points :int32?
      do_not_message_me :bool?
      pin_messages_from :bool?
      auto_follow :bool?
      role :enum? do
        value "normal"
        value "staff"
        value "admin"
        value "super_admin"
      end
      product_account :bool?
      chat_banned :bool?
      designation :string?
      recommended :bool?
      gender :enum? do
        value "male"
        value "female"
        value "unspecified"
      end
      birthdate :string?
      city :string?
      country_code :string?
      biography :string?
      product :object? do
        internal_name :string?
        id :int32?
        name :string?
      end
    end
  end
end
