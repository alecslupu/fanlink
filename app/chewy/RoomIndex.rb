class RoomIndex < Chewy::Index
  define_type Room.includes(:messages) do
  end
end
