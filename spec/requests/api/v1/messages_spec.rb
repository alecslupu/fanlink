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