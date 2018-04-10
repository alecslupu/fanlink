describe "Messages (v2)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @admin_person = create(:person, product: @product, role: :admin)
    @room = create(:room, public: true, status: :active, product: @product)
    @private_room = create(:room, public: false, status: :active, product: @product)
    @private_room.members << @person << @private_room.created_by
  end

  before(:each) do
    logout
  end

  describe "index" do
    before(:all) do
      @index_room = create(:room, product: @person.product, public: true, status: :active)
      @messages = []
      8.times do |n|
        @messages << create(:message, room: @index_room, created_at: Time.now - n.minutes)
      end
      @per_page = 2
    end
    it "should get a paginated list of messages with page 1" do
      login_as(@person)
      get "/rooms/#{@index_room.id}/messages", params: { page: 1, per_page: 2 }
      expect(response).to be_success
      expect(json["messages"].map { |m| m["id"] }).to eq([@messages.first.id.to_s, @messages[1].id.to_s])
    end
    # it "should get a list of messages for a date range with limit" do
    #   login_as(@person)
    #   expect(Message).to receive(:for_date_range).with(room, Date.parse(from), Date.parse(to), 1).and_return(Message.order(created_at: :desc).where(id: [msg2.id]))
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #   expect(response).to be_success
    #   expect(json["messages"].map { |m| m["id"] }).to eq([msg2.id.to_s])
    # end
    # it "should get a list of messages not to include blocked people" do
    #   blocked = create(:person, product: @person.product)
    #   @person.block(blocked)
    #   blocked_msg = create(:message, person: blocked)
    #   login_as(@person)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: "2019-12-01" }
    #   expect(response).to be_success
    #   expect(json["messages"].map { |m| m["id"] }).not_to include(blocked_msg.id)
    # end
    # it "should return unprocessable if invalid from date" do
    #   login_as(@person)
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: "hahahaha", to_date: to, limit: 1 }
    #   expect(response).to be_unprocessable
    #   expect(json["errors"]).to include("invalid date")
    # end
    # it "should return unprocessable if invalid to date" do
    #   login_as(@person)
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: "who me?", limit: 1 }
    #   expect(response).to be_unprocessable
    #   expect(json["errors"]).to include("invalid date")
    # end
    # it "should return unprocessable if missing from date" do
    #   login_as(@person)
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { to_date: to, limit: 1 }
    #   expect(response).to be_unprocessable
    #   expect(json["errors"]).to include("invalid date")
    # end
    # it "should return unprocessable if missing to date" do
    #   login_as(@person)
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, limit: 1 }
    #   expect(response).to be_unprocessable
    #   expect(json["errors"]).to include("invalid date")
    # end
    # it "should return 404 if room from another product" do
    #   login_as(@person)
    #   room_other = create(:room, product: create(:product))
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room_other.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #   expect(response).to be_not_found
    # end
    # it "should return not found if room inactive" do
    #   login_as(@person)
    #   room.inactive!
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #   expect(response).to be_not_found
    #   room.active!
    # end
    # it "should return not found if room deleted" do
    #   login_as(@person)
    #   room.deleted!
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #   expect(response).to be_not_found
    #   room.active!
    # end
    # it "should return unauthorized if not logged in" do
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #   expect(response).to be_unauthorized
    # end
    # describe "#private?" do
    #   it "should get messages if member of private room" do
    #     login_as(@person)
    #     msg = create(:message, room: @private_room, body: "wat wat")
    #     expect(Message).to receive(:for_date_range).with(@private_room, Date.parse(from), Date.parse(to), 1).and_return(Message.order(created_at: :desc).where(id: [msg.id]))
    #     expect_any_instance_of(Room).to receive(:clear_message_counter).with(@private_room.room_memberships.where(person: @person).first)
    #     get "/rooms/#{@private_room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #     expect(response).to be_success
    #     expect(json["messages"].first).to eq(message_json(msg))
    #   end
    #   it "should return not found if not member of private room" do
    #     p = create(:person)
    #     login_as(p)
    #     get "/rooms/#{@private_room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #     expect(response).to be_not_found
    #   end
    # end
  end
end