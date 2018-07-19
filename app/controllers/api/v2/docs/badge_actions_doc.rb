class Api::V2::Docs::BadgeActionsDoc < Api::V2::Docs::BaseDoc
  doc_tag name: 'BadgeActions', desc: "Badge Actions"
  route_base 'api/v2/badge_actions'

  components do
    resp :BadgeActionsPending => ['HTTP/1.1 200 Ok', :json, data:{
      :pending_badge => {
        :badge_action_count => {type: Integer},
        :badge => :BadgeJson
      },
      :badges_awarded => {
        :badge => :BadgeJson
      }
    }]

    body! :BadgeActionCreate, :form, data: {
      :badge_action! => {
        :action_type! => { type: String,  desc: 'Internal name of the action type.' },
        :indentifier => { type: String,  desc: 'The indentifier for this badge action.' },
        }
      }
  end

  api :create, 'POST create a badge action' do
    need_auth :SessionCookie
    body_ref :BadgeActionCreate
    response_ref 200 => :BadgeActionsPending
    response '429', 'Not enough time since last submission of this action type or duplicate action type, person, identifier combination'
  end
end
