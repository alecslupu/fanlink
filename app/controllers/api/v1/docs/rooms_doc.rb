class Api::V1::Docs::RoomsDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Rooms', desc: "Chat rooms"
  route_base 'api/v1/rooms'

  components do
    resp :MessagesArray => ['HTTP/1.1 200 Ok', :json, data:{
      :messages => [
        :message => :Message
      ]
    }]
    resp :MessagesObject => ['HTTP/1.1 200 Ok', :json, data:{
      :message => :Message
    }]
  end

  api :messages, 'Get messages.' do
    desc 'This gets a list of message for a from date, to date, with an optional limit. Messages are returned newest first, and the limit is applied to that ordering.'
    query :room_id!, Integer, desc: 'ID of the room the messages belongs to.'
    query :from_date, String, format: DateTime, desc: 'From date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    query :to_date, String, format: DateTime, desc: 'To date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    query :limit, Integer, desc: 'Limit results to count of limit.'
    response_ref 200 => :MessagesArray
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
