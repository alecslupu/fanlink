class Api::V1::Docs::RoomsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Rooms', desc: "Chat rooms"
  route_base 'api/v1/rooms'
end
