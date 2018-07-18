class Api::V2::Docs::ActivtyTypesDoc < Api::V2::Docs::BaseDoc
  doc_tag name: 'QuestActivities', desc: "Quest Activities"
  route_base 'api/v2/quest_activities'
  # components do
  #   resp :QuestActivityObject  => ['HTTP/1.1 200 Ok', :json, data:{
  #     :activity => :QuestActivityJson
  #   }]

  #   resp :Array  => ['HTTP/1.1 200 Ok', :json, data:{
  #     :activities => [
  #       :activity => :QuestActivityJson
  #     ]
  #   }]

  #   body! :QuestActivityCreateForm, :form, data: {
  #     :quest_activity! => {
  #       :description => { type: String, desc: 'Description of the activity.' },
  #       :hint! => { type: Object}
  #     }
  #   }

  #   body! :QuestActivityUpdateForm, :form, data: {
  #     :! => {
  #     }
  #   }
  # end

  # api :index, 'Get Quest Activities' do
  # need_auth :SessionCookie
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :create, '' do
  # need_auth :SessionCookie
  #   desc ''
  #   query :, , desc: ''
  #   body_ref :
  #   response_ref 200 => :
  # end

  # api :list, '' do
  # need_auth :SessionCookie
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :show, '' do
  # need_auth :SessionCookie
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :update, '' do
  # need_auth :SessionCookie
  #   desc ''
  #   body_ref :
  #   response_ref 200 => :
  # end

  # api :destroy, '' do
  # need_auth :SessionCookie
  #   desc ''
  #   response_ref 200 => :OK
  # end
end
