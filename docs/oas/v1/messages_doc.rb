class Api::V1::MessagesDoc < Api::V1::BaseDoc
  doc_tag name: "Messages", desc: "Messages"
  route_base "api/v1/messages"

  components do
    resp MessagesArray: ["HTTP/1.1 200 Ok", :json, data: {
      messages: [
        message: :Message
      ]
    }]
    resp MessagesObject: ["HTTP/1.1 200 Ok", :json, data: {
      message: :Message
    }]
  end

  api :index, "Get messages." do
    need_auth :SessionCookie
    desc "This gets a list of message for a from date, to date, with an optional limit. Messages are returned newest first, and the limit is applied to that ordering."
    path! :room_id, Integer, desc: "ID of the room the messages belongs to."
    query :from_date, String, format: "date-time", desc: 'From date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    query :to_date, String, format: "date-time", desc: 'To date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    query :limit, Integer, desc: "Limit results to count of limit."
    response_ref 200 => :MessagesArray
  end

  api :create, "Create a message in a room." do
    need_auth :SessionCookie
    desc "This creates a message in a room and posts it to Firebase as appropriate."
    path! :room_id, Integer, desc: "ID of the room the message belongs to."
    form! data: {
      message!: {
        body: { type: String,  desc: "The body of the message." },
        picture: { type: File, desc: "Message picture, this should be `image/gif`, `image/png`, or `image/jpeg`." },
        audio: { type: File, desc: "Message audio, this should be `audio/aac`." },
        mentions: [
          person_id: { type: Integer, desc: "ID of user mentioned" },
          location: { type: Integer, desc: "The location in the message body that the mention is at." },
          length: { type: Integer, desc: "The length of the users name in the mention" }
        ]
      }
    }
    response_ref 200 => :MessagesObject
  end

  api :list, "Get a list of messages without regard to room (ADMIN ONLY)." do
    need_auth :SessionCookie
    desc " This gets a list of messages without regard to room (with possible exception of room filter)."
    query :id_filter, Integer, desc: "Full match on Message id."
    query :person_filter, String, desc: "Full or partial match on person username."
    query :room_id_filter, Integer, desc: "Full match on Room id."
    query :body_filter, String, desc: "Full or partial match on message body."
    query :reported_filter, Boolean, desc: "Filter on whether the message has been reported."
    response_ref 200 => :MessagesArray
  end

  api :show, "Get a single message." do
    need_auth :SessionCookie
    desc "This gets a single message for a message id. Only works for messages in private rooms. If the message author has been blocked by the current user, this will return 404 Not Found."
    path! :room_id, Integer, desc: "ID of the room the message belongs to."
    response_ref 200 => :MessagesObject
  end

  api :update, "Update a message" do
    need_auth :SessionCookie
    desc "This updates a message in a room. Only the hidden field can be changed and only by an admin. If the item is hidden, Firebase will be updated to inform the app that the message has been hidden."
    path! :room_id, Integer, desc: "ID of the room the message belongs to."
    form! data: {
      message!: {
        hidden: { type: Boolean,  desc: "Whether or not the item is hidden." }
      }
    }
    response_ref 200 => :MessagesObject
  end

  api :destroy, "Delete (hide) a single message." do
    need_auth :SessionCookie
    desc "This deletes a single message by marking as hidden. Can only be called by the creator."
    path! :room_id, Integer, desc: "ID of the room the message belongs to."
  end
end
