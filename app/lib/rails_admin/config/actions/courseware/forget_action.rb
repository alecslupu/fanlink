# frozen_string_literal: true
module RailsAdmin
  module Config
    module Actions
      module CourseWare
        class ForgetAction < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)

          register_instance_option :member do
            true
          end

          register_instance_option :http_methods do
            [:get, :delete]
          end

          register_instance_option :route_fragment do
            :forget_action
          end

          register_instance_option :controller do
            proc do
              PersonQuiz.where(person_id: @object.person_id).destroy_all
              CoursePageProgress.where(
                person_id: @object.person_id,
                certcourse_page_id: @object.certcourse.certcourse_page_ids
              ).destroy_all
              if @object.destroy
                flash[:notice] = t('admin.flash.successful', name: @model_config.label, action: t('admin.actions.delete.done'))
              else
                flash[:error] = @object.errors.full_messages.join("<br/>")
              end
              redirect_to action: :index
            end
          end

          register_instance_option :link_icon do
            'icon-stop'
          end
        end
      end
    end
  end
end
