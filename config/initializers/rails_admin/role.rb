# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Role')
  config.model 'Role' do
    list do
      fields :id,
             :name,
             :internal_name
    end
    edit do
      fields :name, :internal_name
      Role.flag_columns.each do |column|
        group column do
          Role.new.as_flag_collection(column).collect(&:first).each do |flag|
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
    show do
      fields :id,
             :name,
             :internal_name,
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
  end
end
