class Api::V1::Docs::SessionDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Session', desc: "User session management."
  route_base 'api/v1/sessions'
end
