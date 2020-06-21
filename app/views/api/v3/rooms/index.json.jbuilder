# frozen_string_literal: true

json.rooms @rooms, partial: 'api/v3/rooms/room', as: :room
