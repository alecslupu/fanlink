class Api::V1::Docs::RelationshipsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Relationships', desc: "User's relationships"
  route_base 'api/v1/relationships'

  components do
  end

  # api :index, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

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
