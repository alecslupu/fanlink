# frozen_string_literal: true


module Api
  module V3
    class PinMessagesController < ApiController
      before_action :admin_only

      load_up_the Person, from: :person_id, only: %i[pin_to]
      load_up_the Room, from: :room_id, only: %i[pin_from]
      load_up_the PinMessage, only: %i[destroy]

      def pin_to
        if Room.find(params[:room_id]).public?
          pm = @person.pin_messages.create(pin_to_params)
          if pm.valid?
            head :ok
          else
            render_errors(pm.errors)
          end
        else
          render_errors(_('Pinning users to private rooms is not allowed.'))
        end
      end

      def pin_from
        if @room.public?
          pm = @room.pin_messages.create(pin_from_params)
          if pm.valid?
            head :ok
          else
            render_errors(pm.errors)
          end
        else
          render_errors(_('Pinning users to private rooms is not allowed.'))
        end
      end

      def destroy
        @pin_message.destroy
        head :ok
      end

      private

      def pin_from_params
        params.permit(:person_id)
      end

      def pin_to_params
        params.permit(:room_id)
      end
    end
  end
end
