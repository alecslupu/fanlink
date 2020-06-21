# frozen_string_literal: true

module RailsAdmin
  module Config
    module Actions
      module CourseWare
        class ResetProgressAction < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)

          register_instance_option :member do
            true
          end

          register_instance_option :http_methods do
            [:get, :delete]
          end

          register_instance_option :route_fragment do
            :reset_progress_action
          end

          register_instance_option :controller do
            proc do
              PersonQuiz.where(
                person_id: @object.person_id
              ).destroy_all
              CoursePageProgress.where(
                person_id: @object.person_id,
                certcourse_page_id: @object.certcourse.certcourse_page_ids
              ).destroy_all
              @object.last_completed_page_id = nil
              @object.is_completed = false
              changes = @object.changes
              if @object.save
                @auditing_adapter && @auditing_adapter.update_object(@object, @abstract_model, _current_user, changes)
                PersonCertificate.update_certification_status(@object.certcourse.certificate_ids, @object.person_id)
                flash[:notice] = t('admin.flash.successful', name: @model_config.label, action: t('admin.actions.reset.done'))
              else
                flash[:error] = @object.errors.full_messages.join("<br/>")
              end
              redirect_to action: :index
            end
          end

          register_instance_option :link_icon do
            "icon-refresh"
          end
        end
      end
    end
  end
end
