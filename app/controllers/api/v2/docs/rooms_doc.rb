class Api::V2::Docs::RoomsDoc < Api::V2::Docs::BaseDoc
  doc_tag name: 'Rooms', desc: "Chat rooms"
  route_base 'api/v2/rooms'

  components do
    resp :RoomsObject => ['HTTP/1.1 200 Ok', :json, data:{
      :room => :Room
    }]
    resp :RoomsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :rooms => [
        :room => :Room
      ]
    }]
  end

  api :index, 'Get a list of rooms.' do
    need_auth :SessionCookie
    desc 'This gets a list of active rooms (public or private, as specified by the "private" parameter).'
    query :private, Boolean, desc: 'Which type of room you want. With true you will get just active private rooms of which the current user is a member. With false (the default), you will get just all active public rooms.'
    response_ref 200 => :RoomsArray
  end

  api :create, 'Create a private room.' do
    need_auth :SessionCookie
    desc 'The creates a private room and makes it active.'
    form! data: {
      :room! => {
        :name! => { type: String, desc: 'The name of the room. Must be between 3 and 26 characters, inclusive.' },
        :description => { type: String, desc: 'The description of the room.'},
        :picture => { type: File, desc: 'Picture for the room.' },
        :member_ids => [
          :ids => { type: Integer, desc: 'Ids of persons to add as members. Users who are blocked by or who are blocking the current user will be silently excluded. You do not need to include the current user, who will be made a member automatically.'}
        ]
      }
    }
    response_ref 200 => :RoomsObject
  end

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

  api :update, 'Update a private room (name).' do
    need_auth :SessionCookie
    desc 'The updates a private room. Only the name can by updated, and only by the owner.'
    form! data: {
      :room! => {
        :name! => { type: String, desc: 'The name of the room. Must be between 3 and 26 characters, inclusive.' },
        :picture => { type: File, desc: 'Picture for the room.' },
      }
    }
    response_ref 200 => :RoomsObject
  end

  api :destroy, 'Delete a private room.' do
    need_auth :SessionCookie
    desc 'The deletes a private room. If it has no messages, it deletes it completely. Otherwise, it just changes the status to deleted.'
    response_ref 200 => :OK
  end

end
