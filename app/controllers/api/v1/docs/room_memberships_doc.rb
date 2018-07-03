class Api::V1::Docs::RoomMembershipsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'RoomMemberships', desc: "What rooms a user belongs to."
  route_base 'api/v1/room_memberships'
end
