module Admin
  class ActionTypesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = ActionType.
    #     page(params[:page]).
    #     per(10)
    # end

    def destroy
      if requested_resource.destroy
        flash[:notice] = translate_with_resource("destroy.success")
      else
        flash[:alert] = requested_resource.errors.full_messages.first
      end
      redirect_to action: :index
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   ActionType.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
