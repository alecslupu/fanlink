module Admin
  class RoomsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Room.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Room.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def create
      params[:room] = params[:room].merge({ public: true, created_by_id: current_user.id })
      super
    end

    private

    def resource_params
      params.require(:room).permit((dashboard.permitted_attributes << %i[ public created_by_id ]).flatten)
    end

  end
end
