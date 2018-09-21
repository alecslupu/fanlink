class AddPersonJsonResponse < Apigen::Migration
  def up
    add_model :person_response do
      type :object do
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
        level :level_response?
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

    add_model :person_private_response do
      type :object do
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
        level :level_response?
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
end
