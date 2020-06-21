# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("RoomSubscriber")

  config.model "RoomSubscriber" do
    label_plural "Room Owners"
    list do
      fields :id,
             :person,
             :room,
             :last_message,
             :last_notification_time
    end
    edit do
      field :person
      field :room do
        associated_collection_scope do
          Proc.new { |scope|
            scope.where(public: true)
          }
        end
      end
    end
    #
    # show do
    #   fields :id,
    #          :title,
    #          :content,
    #          :slug
    # end
  end
end
