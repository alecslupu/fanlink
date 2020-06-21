# frozen_string_literal: true

module RailsAdmin
  module Config
    module Actions
      module PostReport
        class HidePostReportAction < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)

          register_instance_option :member do
            true
          end

          register_instance_option :http_methods do
            [:get, :post]
          end

          register_instance_option :route_fragment do
            :hide_post_action
          end

          register_instance_option :controller do
            proc do
              @object.status = 'post_hidden'
              post = @object.post
              post.status = :deleted
              if post.save! && delete_post(post, post.person.followers)
                changes = @object.changes
                if @object.save!
                  @auditing_adapter && @auditing_adapter.update_object(@object, @abstract_model, _current_user, changes)

                  flash[:notice] = t('admin.flash.successful', name: @model_config.label, action: t('admin.actions.update.done'))
                else
                  flash[:error] = @object.errors.full_messages.join('<br/>')
                end
              else
                flash[:error] = 'Could not save associated message'
              end

              redirect_to action: :index
            end
          end

          register_instance_option :link_icon do
            'icon-off'
          end
        end
      end
    end
  end
end
