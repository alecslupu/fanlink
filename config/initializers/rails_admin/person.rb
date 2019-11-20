RailsAdmin.config do |config|
  config.included_models.push("Person")
  config.model "Person" do

    label_plural "Client Users"

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
          bindings[:view]._current_user.super_admin?
        end
      end
      field :no_of_assignees do
        column_width 20
        pretty_value do
          bindings[:object].assignees.count
        end
        visible do
          bindings[:view]._current_user.super_admin?
        end
      end
      field :no_of_clients do
        column_width 20
        pretty_value do
          bindings[:object].assigners.count
        end
        visible do
          bindings[:view]._current_user.super_admin?
        end
      end
    end
    show do
      fields :id, :username, :email, :name, :picture
      field :role do
        visible do
          bindings[:view]._current_user.super_admin?
        end
      end

      field :designation, :translated do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end

      field :do_not_message_me do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :pin_messages_from do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end

      field :auto_follow do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end

      field :chat_banned do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :product_account do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end

      field :recommended do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :authorized
      field :facebookid do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :facebook_picture_url do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :created_at
      field :level_earned do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :badges do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
    end

    edit do

      fields :username, :email, :name, :picture
      field :role do
        def render
          bindings[:view].render :partial => 'rails_admin/main/client_role_warning', locals: {
            field: self, form: bindings[:form] ,
            client_id: Role.where(internal_name: 'client').first.try(:id)
          }
        end

        visible do
          bindings[:view]._current_user.super_admin?
        end
      end

      field :do_not_message_me do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :pin_messages_from do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end

      field :auto_follow do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :chat_banned do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :product_account do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :recommended do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      fields :authorized, :password
      field :designation, :translated do
        hide do
          bindings[:view]._current_user.client_portal?
        end
      end
      field :assigned_people do
        inline_add do
          false
        end
        visible do
          bindings[:object].client?
        end
        hide do
          bindings[:view]._current_user.client_portal?
        end
        associated_collection_scope do
          normal_role = Role.normals.first
          Proc.new { |scope|
            scope.where(role_id: normal_role.try(:id).to_i  )
          }
        end
      end
      field :designated_people do
        inline_add do
          false
        end
        visible do
          bindings[:object].client?
        end
        hide do
          bindings[:view]._current_user.client_portal?
        end
        associated_collection_scope do
          normal_role = Role.normals.first
          Proc.new { |scope|
            scope.where(role_id: normal_role.try(:id).to_i  )
          }
        end
      end
    end

    export do
      fields :id, :name, :username, :birthdate, :city, :country_code, :email, :created_at, :gender
    end
  end
end
