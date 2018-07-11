class Api::V1::Docs::RoomsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Rooms', desc: "Chat rooms"
  route_base 'api/v1/rooms'

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
