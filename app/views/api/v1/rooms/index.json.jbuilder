# frozen_string_literal: true

json.rooms @rooms, partial: "api/v1/rooms/room", as: :room
