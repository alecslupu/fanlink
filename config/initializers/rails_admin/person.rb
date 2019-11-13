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
        visible do
          bindings[:view]._current_user.super_admin?
        end
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
        visible do
          bindings[:view]._current_user.some_admin?
        end
      end
    end
    show do
      field :id do
      end
      field :username do
      end
      field :email do
      end
      field :name do
      end
      field :picture do
      end
      field :role do
        visible do
          bindings[:view]._current_user.role == "super_admin"
        end
      end

      field :designation, :translated do
        hide do
          bindings[:view]._current_user.client?
        end
      end

      field :do_not_message_me do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :pin_messages_from do
        hide do
          bindings[:view]._current_user.client?
        end
      end

      field :auto_follow do
        hide do
          bindings[:view]._current_user.client?
        end
      end

      field :chat_banned do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :product_account do
        hide do
          bindings[:view]._current_user.client?
        end
      end

      field :recommended do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :authorized
      field :facebookid do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :facebook_picture_url do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :created_at
      field :level_earned do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :badges do
        hide do
          bindings[:view]._current_user.client?
        end
      end
    end

    edit do
      field :username do
      end
      field :email do
      end
      field :name do
      end
      field :picture do
      end
      field :role do
        visible do
          bindings[:view]._current_user.super_admin?
        end
      end

      field :do_not_message_me do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :pin_messages_from do
        hide do
          bindings[:view]._current_user.client?
        end
      end

      field :auto_follow do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :chat_banned do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :product_account do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :recommended do
        hide do
          bindings[:view]._current_user.client?
        end
      end
      field :authorized do
      end
      field :password do
      end
      field :designation, :translated do
        hide do
          bindings[:view]._current_user.client?
        end
      end
    end

    export do
      fields :id, :name, :username, :birthdate, :city, :country_code, :email, :created_at, :gender
    end
  end
end
