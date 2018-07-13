class Api::V1::Docs::BadgesDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Badges', desc: "Badges"
  route_base 'api/v1/badges'
  components do
    resp :BadgesArray => ['HTTP/1.1 200 Ok', :json, data:{
      :badges => [
          :badge => :Badge
      ]
    }]
  end
  api :index, 'Get badges' do
    need_auth :SessionCookie
    query :person_id, Integer, desc: 'The id of the person whose badges you want.'
    response_ref 200 => :BadgesArray
  end
end
