# frozen_string_literal: true
module RailsAdmin
  module Config
    module Actions
      module Message
        class HideAction < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)

          register_instance_option :member do
            true
          end

          register_instance_option :http_methods do
            [:get, :post]
          end

          register_instance_option :route_fragment do
            :hide_action
          end

          register_instance_option :controller do
            proc do
              @object.hidden = true
              changes = @object.changes
              if @object.save
                @auditing_adapter && @auditing_adapter.update_object(@object, @abstract_model, _current_user, changes)
                delete_message(@object, @api_version)
                @object.message_reports.each(&:message_hidden!)
                flash[:notice] = t("admin.flash.successful", name: @model_config.label, action: t("admin.actions.update.done"))
              else
                flash[:error] = @object.errors.full_messages.join("<br/>")
              end
              redirect_to action: :index
            end
          end

          register_instance_option :link_icon do
            "icon-off"
          end
        end
      end
    end
  end
end
