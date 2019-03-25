module Admin
  class PersonCertcoursesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = PersonCertcourse.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   PersonCertcourse.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def reset_progress
      if requested_resource
        PersonQuiz.where(person_id: requested_resource.person_id).destroy_all
        if requested_resource.update({last_completed_page_id: nil, is_completed: false})
          flash[:notice] = translate_with_resource("reset.success")
        else
          flash[:error] = requested_resource.errors.full_messages.join("<br/>")
        end
      end
      redirect_to action: :index
    end

    def forget
      if requested_resource
        PersonQuiz.where(person_id: requested_resource.person_id).destroy_all
        if requested_resource.destroy
          flash[:notice] = translate_with_resource("destroy.success")
        else
          flash[:error] = requested_resource.errors.full_messages.join("<br/>")
        end
      end
      redirect_to action: :index
    end
  end
end
