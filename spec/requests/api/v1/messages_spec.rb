describe "Messages (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @room = create(:room, public: true, status: :active, product: @product)
    @private_room = create(:room, public: false, status: :active, product: @product)
    @private_room.members << @person << @private_room.created_by
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new message in a public room" do
      expect_any_instance_of(Api::V1::MessagesController).to receive(:post_message).and_return(true)
      expect_any_instance_of(Api::V1::MessagesController).not_to receive(:set_message_counters) #msg counters are only for closers!..er, private rooms
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_success
      msg = Message.last
      expect(msg.room).to eq(@room)
      expect(msg.person).to eq(@person)
      expect(msg.body).to eq(body)
      expect(json["message"]).to eq(message_json(msg))
    end
    it "should create a new message in a private room" do
      expect_any_instance_of(Api::V1::MessagesController).to receive(:post_message).and_return(true)
      expect_any_instance_of(Api::V1::MessagesController).to receive(:set_message_counters).and_return(true)
      room = create(:room, product: @product, created_by: @person, status: :active)
      room.members << @person
      other_member = create(:person, product: @person.product)
      room.members << other_member
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{room.id}/messages", params: { message: { body: body } }
      expect(response).to be_success
      msg = Message.last
      expect(msg.room).to eq(room)
      expect(msg.person).to eq(@person)
      expect(msg.body).to eq(body)
      expect(room.room_memberships.find_by(person_id: other_member.id).message_count).to eq(1) # not updating for message creator
      expect(room.room_memberships.find_by(person_id: @person.id).message_count).to eq(0) # not updating for message creator
      expect(json["message"]).to eq(message_json(msg))
    end
    it "should not create a new message in an inactive room" do
      @room.inactive!
      expect_any_instance_of(Api::V1::MessagesController).to_not receive(:post_message)
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("room is no longer active")
      @room.active!
    end
    it "should not create a new message in a deleted room" do
      @room.deleted!
      expect_any_instance_of(Api::V1::MessagesController).to_not receive(:post_message)
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("room is no longer active")
      @room.active!
    end
    it "should destroy the message and return error if unable to post message to socket" do
      expect_any_instance_of(Api::V1::MessagesController).to receive(:post_message).and_return(false)
      login_as(@person)
      body = "Do you like my body?"
      precount = Message.count
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response.status).to eq(503)
      expect(Message.count - precount).to eq(0)
      expect(json["errors"]).to include("problem sending the message")
    end
  end

  describe "#destroy" do
    it "should hide message from original creator" do
      expect_any_instance_of(Api::V1::MessagesController).to receive(:delete_message).and_return(nil)
      login_as(@person)
      msg = create(:message, person: @person, room: @private_room, body: "this is my body")
      delete "/rooms/#{@private_room.id}/messages/#{msg.id}"
      expect(response).to be_success
      expect(msg.reload.hidden).to be_truthy
    end
    it "should not hide message from someone else" do
      expect_any_instance_of(Api::V1::MessagesController).to_not receive(:delete_message)
      p = create(:person)
      login_as(@person)
      msg = create(:message, person: p, room: @room, body: "this is my body")
      delete "/rooms/#{@room.id}/messages/#{msg.id}"
      expect(response).to be_unauthorized
      expect(msg.reload.hidden).to be_falsey
    end
    it "should not hide message if not logged in" do
      expect_any_instance_of(Api::V1::MessagesController).to_not receive(:delete_message)
      msg = create(:message, person: @person, room: @room, body: "this is my body")
      delete "/rooms/#{@room.id}/messages/#{msg.id}"
      expect(response).to be_unauthorized
      expect(msg.reload.hidden).to be_falsey
    end
  end

  describe "#index" do
    let(:room) { create(:room, product: @person.product, public: true, status: :active) }
    let(:msg1) { create(:message, room: room, created_at: Date.today - 1.day) }
    let(:msg2) { create(:message, room: room) }
    let(:from) { "2018-01-01" }
    let(:to) { "2018-01-03" }
    it "should get a list of messages for a date range without limit" do
      login_as(@person)
      expect(Message).to receive(:for_date_range).with(room, Date.parse(from), Date.parse(to), nil).and_return(Message.order(created_at: :desc).where(id: [msg1.id, msg2.id]))
      expect_any_instance_of(Api::V1::MessagesController).to_not receive(:set_message_counters) #only for priv rooms
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to }
      expect(response).to be_success
      expect(json["messages"].map { |m| m["id"] }).to eq([msg2.id.to_s, msg1.id.to_s])
    end
    it "should get a list of messages for a date range with limit" do
      login_as(@person)
      expect(Message).to receive(:for_date_range).with(room, Date.parse(from), Date.parse(to), 1).and_return(Message.order(created_at: :desc).where(id: [msg2.id]))
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
      expect(response).to be_success
      expect(json["messages"].map { |m| m["id"] }).to eq([msg2.id.to_s])
    end
    it "should get a list of messages not to include blocked people" do
      blocked = create(:person, product: @person.product)
      @person.block(blocked)
      blocked_msg = create(:message, person: blocked)
      login_as(@person)
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: "2019-12-01" }
      expect(response).to be_success
      expect(json["messages"].map { |m| m["id"] }).not_to include(blocked_msg.id)
    end
    it "should return unprocessable if invalid from date" do
      login_as(@person)
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: "hahahaha", to_date: to, limit: 1 }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("invalid date")
    end
    it "should return unprocessable if invalid to date" do
      login_as(@person)
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: "who me?", limit: 1 }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("invalid date")
    end
    it "should return unprocessable if missing from date" do
      login_as(@person)
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { to_date: to, limit: 1 }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("invalid date")
    end
    it "should return unprocessable if missing to date" do
      login_as(@person)
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, limit: 1 }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("invalid date")
    end
    it "should return 404 if room from another product" do
      login_as(@person)
      room_other = create(:room, product: create(:product))
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room_other.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
      expect(response).to be_not_found
    end
    it "should return not found if room inactive" do
      login_as(@person)
      room.inactive!
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
      expect(response).to be_not_found
      room.active!
    end
    it "should return not found if room deleted" do
      login_as(@person)
      room.deleted!
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
      expect(response).to be_not_found
      room.active!
    end
    it "should return unauthorized if not logged in" do
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
      expect(response).to be_unauthorized
    end
    describe "#private?" do
      it "should get messages if member of private room" do
        login_as(@person)
        msg = create(:message, room: @private_room, body: "wat wat")
        expect(Message).to receive(:for_date_range).with(@private_room, Date.parse(from), Date.parse(to), 1).and_return(Message.order(created_at: :desc).where(id: [msg.id]))
        expect_any_instance_of(Api::V1::MessagesController).to receive(:clear_message_counter).with(@private_room, @person).and_return(true)
        get "/rooms/#{@private_room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
        expect(response).to be_success
        expect(json["messages"].first).to eq(message_json(msg))
      end
      it "should return not found if not member of private room" do
        p = create(:person)
        login_as(p)
        get "/rooms/#{@private_room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
        expect(response).to be_not_found
      end
    end
  end

  describe "#show" do
    it "should get a single private message" do
      login_as(@person)
      msg = create(:message, room: @private_room, body: "this is my body")
      get "/rooms/#{@private_room.id}/messages/#{msg.id}"
      expect(response).to be_success
      expect(json["message"]).to eq(message_json(msg))
    end
    it "should not get a single private message from a blocked user" do
      login_as(@person)
      blocked = create(:person, product: @person.product)
      @person.block(blocked)
      msg = create(:message, room: @private_room, body: "this is my body", person: blocked)
      get "/rooms/#{@private_room.id}/messages/#{msg.id}"
      expect(response).to be_not_found
    end
    it "should not get message if not logged in" do
      msg = create(:message, room: @private_room, body: "this is my body")
      get "/rooms/#{@private_room.id}/messages/#{msg.id}"
      expect(response).to be_unauthorized
    end
    it "should not get message if not a member of the room" do
      p = create(:person)
      login_as(p)
      msg = create(:message, room: @private_room, body: "this is my body")
      get "/rooms/#{@private_room.id}/messages/#{msg.id}"
      expect(response).to be_not_found
    end
    it "should not get message if message hidden" do
      login_as(@person)
      msg = create(:message, room: @private_room, body: "this is my body", hidden: true)
      get "/rooms/#{@private_room.id}/messages/#{msg.id}"
      expect(response).to be_not_found
    end
    it "should not get message from public room" do
      p = create(:person)
      login_as(p)
      msg = create(:message, room: @room, body: "this is my body")
      get "/rooms/#{@room.id}/messages/#{msg.id}"
      expect(response).to be_not_found
    end
  end
end
