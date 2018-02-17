module Admin
  class MessageReportsController < Admin::ApplicationController

    def update

    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   MessageReport.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
