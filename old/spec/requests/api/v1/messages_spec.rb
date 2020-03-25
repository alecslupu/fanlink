describe "Messages (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @admin_person = create(:person, product: @product, role: :admin)
    @room = create(:room, public: true, status: :active, product: @product)
    @private_room = create(:room, public: false, status: :active, product: @product)
    @private_room.members << @person << @private_room.created_by
    @mentioned1 = create(:person, product: @product)
    @mentioned2 = create(:person, product: @product)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new message in a public room" do
      expect_any_instance_of(Message).to receive(:post)
      expect_any_instance_of(Room).not_to receive(:increment_message_counters) #msg counters are only for closers!..er, private rooms
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_success
      msg = Message.last
      expect(msg.room).to eq(@room)
      expect(msg.person).to eq(@person)
      expect(msg.body).to eq(body)
      # expect(json["message"]).to eq(message_json(msg))
      expect(message_json(json["message"])).to be true
    end
    it "should create a new message in a public room with mentions" do
      expect_any_instance_of(Message).to receive(:post)
      expect_any_instance_of(Room).not_to receive(:increment_message_counters)
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages",
           params: { message: { body: body,
                                mentions: [ { person_id: @mentioned1.id,
                                              location: 11,
                                              length: 8 },
                                            { person_id: @mentioned2.id,
                                              location: 14,
                                              length: 4 } ]
                                }
                    }
      expect(response).to be_success
      msg = Message.last
      expect(msg.mentions.count).to eq(2)
      expect(msg.mentions.first.location).to eq(11)
      expect(msg.mentions.first.length).to eq(8)
      expect(json["message"]["mentions"].count).to eq(2)
    end
    it "should not create a new message in a public room with a mention without a person_id" do
      expect_any_instance_of(Message).not_to receive(:post)
      login_as(@person)
      body = "Do you like my body?"
      expect {
        post "/rooms/#{@room.id}/messages",
             params: { message: { body: body,
                                  mentions: [ { location: 4, length: 11 },
                                              { person_id: @mentioned2.id,
                                                location: 5, length: 1 } ]
        } }
      }.to change { Message.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).not_to be_empty
    end
    it "should create a new message in a private room" do
      expect_any_instance_of(Message).to receive(:post)
      expect_any_instance_of(Message).to receive(:private_message_push)
      expect_any_instance_of(Room).to receive(:increment_message_counters)
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
      # expect(json["message"]).to eq(message_json(msg))
      expect(message_json(json["message"])).to be true
    end
    it "should create a new message in a private room with a mention" do
      expect_any_instance_of(Message).to receive(:post)
      expect_any_instance_of(Message).to receive(:private_message_push)
      expect_any_instance_of(Room).to receive(:increment_message_counters)
      room = create(:room, product: @product, created_by: @person, status: :active)
      room.members << @person
      other_member = create(:person, product: @person.product)
      room.members << other_member
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{room.id}/messages",
           params: { message: { body: body, mentions: [{ person_id: @mentioned1.id,
                                                                      location: 14,
                                                                      length: 4 } ]
                    } }
      expect(response).to be_success
      msg = Message.last
      expect(msg.mentions.count).to eq(1)
      expect(json["message"]["mentions"].count).to eq(1)
    end
    it "should not create a new message in an inactive room" do
      @room.inactive!
      expect_any_instance_of(Message).to_not receive(:post)
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("This room is no longer active.")
      @room.active!
    end
    it "should not create a new message in a deleted room" do
      @room.deleted!
      expect_any_instance_of(Message).to_not receive(:post)
      login_as(@person)
      body = "Do you like my body?"
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("This room is no longer active.")
      @room.active!
    end
    it "should not let banned user create a message in public chat room" do
      expect_any_instance_of(Message).not_to receive(:post)
      banned = create(:person, chat_banned: true)
      login_as(banned)
      body = "Do you like my body?"
      precount = Message.count
      post "/rooms/#{@room.id}/messages", params: { message: { body: body } }
      expect(response).to be_unprocessable
      expect(Message.count - precount).to eq(0)
      expect(json["errors"]).to include("You are banned from chat.")
    end
    it "should let banned user create a new message in a private room" do
      expect_any_instance_of(Message).to receive(:post)
      expect_any_instance_of(Room).to receive(:increment_message_counters)
      room = create(:room, product: @product, created_by: @person, status: :active)
      room.members << @person
      other_member = create(:person, product: @person.product, chat_banned: true)
      room.members << other_member
      login_as(other_member)
      body = "Do you like my body?"
      expect {
        post "/rooms/#{room.id}/messages", params: { message: { body: body } }
      }.to change { Message.count }.by(1)
      expect(response).to be_success
    end
  end

  describe "#destroy" do
    it "should hide message from original creator" do
      expect_any_instance_of(Message).to receive(:delete_real_time)
      login_as(@person)
      msg = create(:message, person: @person, room: @private_room, body: "this is my body")
      delete "/rooms/#{@private_room.id}/messages/#{msg.id}"
      expect(response).to be_success
      expect(msg.reload.hidden).to be_truthy
    end
    it "should hide message by admin" do
      expect_any_instance_of(Message).to receive(:delete_real_time)
      login_as(@person)
      msg = create(:message, person: @person, room: @private_room, body: "this is my body")
      delete "/rooms/#{@private_room.id}/messages/#{msg.id}"
      expect(response).to be_success
      expect(msg.reload.hidden).to be_truthy
    end
    it "should not hide message from someone else" do
      expect_any_instance_of(Message).to_not receive(:delete_real_time)
      p = create(:person)
      login_as(@person)
      msg = create(:message, person: p, room: @room, body: "this is my body")
      delete "/rooms/#{@room.id}/messages/#{msg.id}"
      expect(response).to be_unauthorized
      expect(msg.reload.hidden).to be_falsey
    end
    it "should not hide message if not logged in" do
      expect_any_instance_of(Message).to_not receive(:delete_real_time)
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
      expect_any_instance_of(Room).to_not receive(:increment_message_counters) #only for priv rooms
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
      expect(json["errors"]).to include("Missing or invalid date(s)")
    end
    it "should return unprocessable if invalid to date" do
      login_as(@person)
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: "who me?", limit: 1 }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Missing or invalid date(s)")
    end
    it "should return unprocessable if missing from date" do
      login_as(@person)
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { to_date: to, limit: 1 }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Missing or invalid date(s)")
    end
    it "should return unprocessable if missing to date" do
      login_as(@person)
      expect(Message).to_not receive(:for_date_range)
      get "/rooms/#{room.id}/messages", params: { from_date: from, limit: 1 }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Missing or invalid date(s)")
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
        expect_any_instance_of(Room).to receive(:clear_message_counter).with(@private_room.room_memberships.where(person: @person).first)
        get "/rooms/#{@private_room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
        expect(response).to be_success
        # expect(json["messages"].first).to eq(message_json(msg))
        expect(message_json(json["messages"].first)).to be true
      end
      it "should return not found if not member of private room" do
        p = create(:person)
        login_as(p)
        get "/rooms/#{@private_room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
        expect(response).to be_not_found
      end
    end
  end

  describe "#list" do
    let(:product) { create(:product, name: "Test Product 321", internal_name: "test_product_321") }
    let!(:room1) { create(:room, product: product, public: true) }
    let!(:room2) { create(:room, product: product, public: false) }
    let!(:membership1) { create(:room_membership, room: room2, person: create(:person, username: "membership1", product: product)) }
    let!(:membership2) { create(:room_membership, room: room2) }
    let!(:msg1) { create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, product: product, username: "message1person")) }
    let!(:msg2) { create(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2") }
    let!(:msg12) { create(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12") }
    let!(:msg13) { create(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13") }
    let!(:msg14) { create(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14") }
    let!(:msg3) { create(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3") }
    let!(:admin) { create(:person, product: product, role: :admin) }
    it "should give you all messages from all rooms with no page specified" do
      toget = [msg1, msg2, msg12, msg13, msg14, msg3 ]
      login_as(admin)
      get "/messages"
      expect(response).to be_success
      expect(json["messages"].count).to eq(toget.size)
    end
    it "should give you page 1 with 2 per page" do
      toget = [msg3, msg14]
      login_as(admin)
      get "/messages", params: { page: 1, per_page: 2 }
      expect(response).to be_success
      expect(json["messages"].count).to eq(toget.size)
      # expect(json["messages"].first).to eq(message_list_json(toget.first))
      # expect(json["messages"].last).to eq(message_list_json(toget.last))
      expect(message_list_json(json["messages"].first)).to be true
      expect(message_list_json(json["messages"].last)).to be true
    end
    it "should give you page 1 with 2 per page if no page specified" do
      toget = [msg3, msg14]
      login_as(admin)
      get "/messages", params: { per_page: 2 }
      expect(response).to be_success
      expect(json["messages"].count).to eq(toget.size)
      # expect(json["messages"].first).to eq(message_list_json(toget.first))
      # expect(json["messages"].last).to eq(message_list_json(toget.last))
      expect(message_list_json(json["messages"].first)).to be true
      expect(message_list_json(json["messages"].last)).to be true
    end
    it "should give you page 2 with 2 per page" do
      toget = [msg13, msg12]
      login_as(admin)
      get "/messages", params: { page: 2, per_page: 2 }
      expect(response).to be_success
      expect(json["messages"].count).to eq(toget.size)
      # expect(json["messages"].first).to eq(message_list_json(toget.first))
      # expect(json["messages"].last).to eq(message_list_json(toget.last))
      expect(message_list_json(json["messages"].first)).to be true
      expect(message_list_json(json["messages"].last)).to be true
    end
    it "should give you messages filtered on id" do
      login_as(admin)
      get "/messages", params: { id_filter: msg1.id }
      expect(response).to be_success
      expect(json["messages"].count).to eq(1)
      # expect(json["messages"].first).to eq(message_list_json(msg1))
      expect(message_list_json(json["messages"].first)).to be true
    end
    it "should give you messages filtered on person" do
      login_as(admin)
      get "/messages", params: { person_filter: "ship1" }
      expect(response).to be_success
      expect(json["messages"].count).to eq(1)
      # expect(json["messages"].first).to eq(message_list_json(msg3))
      expect(message_list_json(json["messages"].first)).to be true
    end
    it "should give you messages filtered on room" do
      toget = [msg14, msg13, msg12, msg2, msg1 ]
      login_as(admin)
      get "/messages", params: { room_id_filter: room1.id }
      expect(response).to be_success
      expect(json["messages"].count).to eq(toget.size)
      # expect(json["messages"].last).to eq(message_list_json(toget.last))
      # expect(json["messages"].first).to eq(message_list_json(toget.first))
      expect(message_list_json(json["messages"].last)).to be true
      expect(message_list_json(json["messages"].first)).to be true
    end
    it "should give you messages filtered on body" do
      login_as(admin)
      get "/messages", params: { body_filter: "his is msg1" }
      expect(response).to be_success
      expect(json["messages"].count).to eq(1)
      # expect(json["messages"].first).to eq(message_list_json(msg1))
      expect(message_list_json(json["messages"].first)).to be true
    end
    it "should give you reported messages" do
      create(:message_report, message: msg1)
      login_as(admin)
      get "/messages", params: { reported_filter: "Yes" }
      expect(response).to be_success
      expect(json["messages"].count).to eq(1)
      # expect(json["messages"].first).to eq(message_list_json(msg1))
      expect(message_list_json(json["messages"].first)).to be true
    end
    it "should return unauth if not logged in" do
      get "/messages"
      expect(response).to be_unauthorized
    end
    it "should return unauth if not admin" do
      login_as(create(:person, product: product, role: :normal))
      get "/messages"
      expect(response).to be_unauthorized
    end
    it "should give you messages filtered on room and person" do
      login_as(admin)
      get "/messages", params: { room_id_filter: room1.id, person_filter:  "essage1" }
      expect(response).to be_success
      expect(json["messages"].count).to eq(1)
      # expect(json["messages"].first).to eq(message_list_json(msg1))
      expect(message_list_json(json["messages"].first)).to be true
    end
  end
  describe "#show" do
    it "should get a single private message" do
      login_as(@person)
      msg = create(:message, room: @private_room, body: "this is my body")
      get "/rooms/#{@private_room.id}/messages/#{msg.id}"
      expect(response).to be_success
      #expect(json["message"]).to eq(message_json(msg))
      expect(message_json(json["message"])).to be true
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

  describe "#update" do
    it "should hide a message by an admin" do
      expect_any_instance_of(Message).to receive(:delete_real_time)
      login_as(@admin_person)
      msg = create(:message, room: create(:room, public: true, product: @product))
      expect(msg.hidden).to be_falsey
      patch "/messages/#{msg.id}", params: { message: { hidden: true } }
      expect(response).to be_success
      expect(msg.reload.hidden).to be_truthy
      # expect(json["message"]).to eq(message_list_json(msg))
      expect(message_list_json(json["message"])).to be true
    end
    it "should unhide a message by an admin" do
      expect_any_instance_of(Message).to_not receive(:delete_real_time)
      login_as(@admin_person)
      msg = create(:message, room: create(:room, public: true, product: @product), hidden: true)
      expect(msg.hidden).to be_truthy
      patch "/messages/#{msg.id}", params: { message: { hidden: false } }
      expect(response).to be_success
      expect(msg.reload.hidden).to be_falsey
      # expect(json["message"]).to eq(message_list_json(msg))
      expect(message_list_json(json["message"])).to be true
    end
    it "should not hide a message if not logged in" do
      expect_any_instance_of(Message).to_not receive(:delete_real_time)
      logout
      msg = create(:message, room: create(:room, public: true, product: @product))
      patch "/messages/#{msg.id}", params: { message: { hidden: true } }
      expect(response).to be_unauthorized
      expect(msg.reload.hidden).to be_falsey
    end
  end
end
