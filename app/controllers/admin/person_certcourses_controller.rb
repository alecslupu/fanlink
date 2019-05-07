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
        PersonQuiz.where(
          person_id: requested_resource.person_id
        ).destroy_all
        CoursePageProgress.where(
          person_id: requested_resource.person_id,
          certcourse_page_id: requested_resource.certcourse.certcourse_page_ids
        ).destroy_all
        if requested_resource.update(last_completed_page_id: nil, is_completed: false)
          update_certification_status(requested_resource.certcourse.certificate_ids, requested_resource.person_id)
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
        CoursePageProgress.where(
          person_id: requested_resource.person_id,
          certcourse_page_id: requested_resource.certcourse.certcourse_page_ids
        ).destroy_all
        if requested_resource.destroy
          flash[:notice] = translate_with_resource("destroy.success")
        else
          flash[:error] = requested_resource.errors.full_messages.join("<br/>")
        end
      end
      redirect_to action: :index
    end

  private
    def update_certification_status(certificate_ids, user_id)
      # TODO find a better way to write this
      # TODO move it in a job
      PersonCertificate.where(person_id: user_id, certificate_id: certificate_ids).find_each do |c|
        person_certcourses = PersonCertcourse.where(person_id: user_id, certcourse_id: c.certificate.certcourse_ids).pluck(:is_completed)
        # raise ({c_size: c.certificate.certcourse_ids.size, p_size: person_certcourses.size, pc: person_certcourses}).inspect
        c.is_completed = (c.certificate.certcourses.size == person_certcourses.size) && person_certcourses.inject(true, :&)
        c.save!
      end
    end
  end
end
