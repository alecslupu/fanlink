RailsAdmin.config do |config|
  config.included_models.push("Person")
  config.model "Person" do
    object_label_method do
      :username
    end

    configure :level_earned do
    end

    configure :password do
    end
    list do
      field :username do
        column_width 150
      end
      field :email do
        column_width 175
      end
      field :name do
        column_width 100
      end
      field :picture do
        column_width 70
      end
      field :role do
        column_width 70
      end
      field :created_at do
        column_width 100
      end
      field :authorized do
        column_width 20
      end
      field :notification_device_ids do
        column_width 100
        pretty_value do
          bindings[:view].link_to "#{ bindings[:object].notification_device_ids.size} notification device ids", bindings[:view].rails_admin.show_path('person', bindings[:object].id)
        end
      end
    end
    show do
      fields :id,
             :username,
             :email,
             :name,
             :picture

      field :role do
        visible do
          bindings[:view]._current_user.role == "super_admin"
        end
      end
      fields :designation,
             :do_not_message_me,
             :pin_messages_from,
             :auto_follow,
             :chat_banned,
             :product_account,
             :recommended,
             :authorized,
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
             :picture
      field :role do
        visible do
          bindings[:view]._current_user.role == "super_admin"
        end
      end

      fields :do_not_message_me,
             :pin_messages_from,
             :auto_follow,
             :chat_banned,
             :product_account,
             :recommended,
             :authorized,
             :password
      field :designation, :translated
    end
  end
end
