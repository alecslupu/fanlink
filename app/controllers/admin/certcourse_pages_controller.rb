module Admin
  class CertcoursePagesController < Admin::ApplicationController


    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    def default_params
      params[:order] ||= "certcourse_page_order"
      params[:direction] ||= "desc"
    end

  end
end
