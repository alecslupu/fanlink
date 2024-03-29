# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('PortalAccess')

  config.model 'PortalAccess' do
    list do
      fields :id, :person, :post, :chat
    end
    show do
      fields :id,
             :person,
             :post,
             :chat,
             :event,
             :merchandise,
             :user,
             :badge,
             :reward,
             :quest,
             :beacon,
             :reporting,
             :interest,
             :root
    end
    edit do
      field :person
      PortalAccess.flag_columns.each do |column|
        group column do
          PortalAccess.new.as_flag_collection(column).collect(&:first).each do |flag|
            field flag, :boolean do
              visible do
                has_permission = bindings[:view]._current_user.full_permission_list.include?(flag)
                is_root = bindings[:view]._current_user.root?
                (has_permission || is_root)
              end
            end
          end
        end
      end
    end
  end
end
