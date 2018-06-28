class Api::V1::Docs::BadgeActionsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Badge Action', desc: "Badge Actions"
  route_base 'api/v1/badge_actions'
  api :create, 'POST create a badge action', use: 'SessionCookie' do
    form! data: {
          :badge_action! => {
            :action_type! => { type: String,  desc: 'Internal name of the action type.' },
            :indentifier => { type: String,  desc: 'The indentifier for this badge action.' },
            }
          },
          examples: {
            :right_input => [ 'test_action', 'badge_1_test_action' ],
            :wrong_input => [ 'Test Action', 'Badge1 TestAction'  ]
          }
    end

end
