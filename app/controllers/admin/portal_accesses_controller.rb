module Admin
  class PortalAccessesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = PortalAccess.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   PortalAccess.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def new
      resource = resource_class.new(person_id: params[:person_id])
      authorize_resource(resource)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }
    end

    protected

    # Workaround to fix FLAPI-708, FLAPI-718
    def set_current_tenant(current_tenant_object)
      nil
    end

  end
end
