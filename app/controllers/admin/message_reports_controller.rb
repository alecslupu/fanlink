module Admin
  class MessageReportsController < Admin::ApplicationController
    include Messaging

    def index
      #search_term = params[:search].to_s.strip
      resources = MessageReport.for_product(ActsAsTenant.current_tenant).page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
          resources: resources,
          #search_term: search_term,
          page: page,
          show_search_bar: false
      }
    end

    def update
      message_report = MessageReport.find(params["id"])
      message_report.status = params["message_report"]["status"]
      message = message_report.message
      errored = false
      if message_report.status == "message_hidden"
        message.hidden = true
        if message.save && delete_message(message)
          message_report.save
        else
          errored = true
        end
      else
        message.hidden = false
        if !message.save
          errored = true
        end
      end
      if errored
        render status: :unprocessable_entity, json: { error: "Unable to update the message. Please try again later." }
      else
        render status: :ok, json: { message: (message.hidden?) ? "Message hidden" : "Message not hidden" }
      end
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   MessageReport.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
