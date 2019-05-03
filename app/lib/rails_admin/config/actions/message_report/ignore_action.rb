module RailsAdmin
  module Config
    module Actions
      module MessageReport
        class IgnoreAction < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)

          register_instance_option :member do
            true
          end

          register_instance_option :http_methods do
            [:get, :post]
          end

          register_instance_option :route_fragment do
            :ignore_action
          end

          register_instance_option :controller do
            proc do
                @object.status = "no_action_needed"
                message = @object.message
                message.hidden = false
                if message.save
                  changes = @object.changes
                  if @object.save
                    @auditing_adapter && @auditing_adapter.update_object(@object, @abstract_model, _current_user, changes)

                    flash[:notice] = t('admin.flash.successful', name: @model_config.label, action: t('admin.actions.update.done'))
                  else
                    flash[:error] = @object.errors.full_messages.join("<br/>")
                  end
                else
                  flash[:error] = "Could not save associated message"
                end

                redirect_to action: :index
            end
          end

          register_instance_option :link_icon do
            'icon-ok'
          end
        end
      end
    end
  end
end
