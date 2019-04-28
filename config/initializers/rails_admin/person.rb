RailsAdmin.config do |config|
  config.included_models.push("Person")
  config.model "Person" do
    configure :level_earned do
    end
    list do
      fields :username,
             :email,
             :name,
             :picture,
             :role,
             :created_at,
             :notification_device_ids
    end
    show do
      fields :id,
             :username,
             :email,
             :name,
             :picture,
             :role,
             :designation,
             :do_not_message_me,
             :pin_messages_from,
             :auto_follow,
             :chat_banned,
             :product_account,
             :recommended,
             :facebookid,
             :facebook_picture_url,
             :created_at,
             :updated_at,
             :level_earned,
             :badges
    end

    edit do
      fields :username,
             :email,
             :name,
             :picture,
             :role,
             :do_not_message_me,
             :pin_messages_from,
             :auto_follow,
             :chat_banned,
             :product_account,
             :recommended,
             :password
      field :designation, :translated
    end
  end
end
