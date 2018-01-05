describe "Messages (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @room = create(:room, public: true, status: :active, product: @product)
    @private_room = create(:room, public: false, status: :active, product: @product)
    @private_room.members << @person
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new message in a public room" do
      expect_any_instance_of(Api::V1::MessagesController).to receive(:post_message).and_return(nil)
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_success
      msg = Message.last
      expect(msg.room).to eq(@room)
      expect(msg.person).to eq(@person)
      expect(msg.body).to eq(body)
    end
    it "should not create a new message in an inactive room" do
      @room.inactive!
      expect_any_instance_of(Api::V1::MessagesController).to_not receive(:post_message)
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Room is not active")
      @room.active!
    end
    it "should not create a new message in a deleted room" do
      @room.deleted!
      expect_any_instance_of(Api::V1::MessagesController).to_not receive(:post_message)
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Room is not active")
      @room.active!
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
    it "should return unprocessable if room inactive" do
      login_as(@person)
      room.inactive!
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
      expect(response).to be_unprocessable
      room.active!
    end
    it "should return unprocessable if room deleted" do
      login_as(@person)
      room.deleted!
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
      expect(response).to be_unprocessable
      room.active!
    end
    it "should return unauthorized if not logged in" do
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
      expect(response).to be_unauthorized
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
      expect(response).to be_unauthorized
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
