class Api::V1::Docs::BadgeActionsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'BadgeActions', desc: "Badge Actions"
  route_base 'api/v1/badge_actions'

  components do
    resp :BadgeActionsPending => ['HTTP/1.1 200 Ok', :json, data:{
      :pending_badge => {
        :badge_action_count => {type: Integer},
        :badge => :Badge
      }
    }]
    resp :BadgeActionsAwarded => ['HTTP/1.1 200 Ok', :json, data:{
      :badges_awarded => {
        :badge => :Badge
      }
    }]
  end

  api :create, 'POST create a badge action' do
    form! data: {
          :badge_action! => {
            :action_type! => { type: String,  desc: 'Internal name of the action type.' },
            :indentifier => { type: String,  desc: 'The indentifier for this badge action.' },
            }
          }
    response_ref 200 => :BadgeActionPending
    response_ref 200 => :BadgeActionAwarded
    response '422', 'Action type invalid, cannot do that action again, blah blah blah'
    response '429', 'Not enough time since last submission of this action type or duplicate action type, person, identifier combination'
  end
end
