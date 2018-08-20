class Api::V1::RecommendedPeopleDoc < Api::V1::BaseDoc
  doc_tag name: "RecommendedPeople", desc: "Recommended People"
  route_base "api/v1/recommended_people"

  components do
    resp RecommendedPeopleArray: ["HTTP/1.1 200 Ok", :json, data: {
      people: [
        person: :Person
      ]
    }]
  end

  api :index, "Get recommended people." do
    need_auth :SessionCookie
    desc 'This is used to get a list of people flagged as "recommended". It excludes the current user and anyone the current user is following.'
    response_ref 200 => :RecommendedPeopleArray
  end

  # api :create, '' do
  #   desc ''
  #   query :, , desc: ''
  #   form! data: {
  #     :! => {
  #     }
  #   }
  #   response_ref 200 => :
  # end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :show, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :update, '' do
  #   desc ''
  #   form! data: {
  #     :! => {

  #     }
  #   }
  #   response_ref 200 => :
  # end

  # api :destroy, '' do
  #   desc ''
  #   response_ref 200 => :OK
  # end
end
