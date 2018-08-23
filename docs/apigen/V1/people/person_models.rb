FanlinkApi::API.model :person_app_json do
  type :object do
    person :object do
      id :int32
      username :string
      username_canonical :string
      email :string
      name :string
      product_id :int32
      crypted_password :string
      salt :string
      created_at :string
      updated_at :string
      facebookid :string
      facebook_picture_url :string
      picture_file_name :string
      picture_content_type :string
      picture_file_size :int32
      picture_updated_at :string
      do_not_message_me :bool
      pin_messages_from :bool
      auto_follow :bool
      role :int32
      reset_password_token :string
      reset_password_token_expires_at :string
      reset_password_email_sent_at :string
      product_account :bool
      chat_banned :bool
      designation :string
      recommended :bool
      gender :int32
      birthdate :string
      city :string
      country_code :string
      biography :string
      tester :bool
    end
  end
end


FanlinkApi::API.model :person_private_app_json do
  type :object do
    person :object do
      id :int32
      username :string
      username_canonical :string
      email :string
      name :string
      product_id :int32
      crypted_password :string
      salt :string
      created_at :string
      updated_at :string
      facebookid :string
      facebook_picture_url :string
      picture_file_name :string
      picture_content_type :string
      picture_file_size :int32
      picture_updated_at :string
      do_not_message_me :bool
      pin_messages_from :bool
      auto_follow :bool
      role :int32
      reset_password_token :string
      reset_password_token_expires_at :string
      reset_password_email_sent_at :string
      product_account :bool
      chat_banned :bool
      designation :string
      recommended :bool
      gender :int32
      birthdate :string
      city :string
      country_code :string
      biography :string
      tester :bool
    end
  end
end
