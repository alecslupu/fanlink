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
      @pinned_person = create(:person, pin_messages_from: true, product: @product)
      @pinned_messages = []
      2.times do |n|
        msg = create(:message, room: @index_room, created_at: Time.now - (n + 10).minutes, person: @pinned_person)
        @messages << msg
        @pinned_messages << msg
      end
      @per_page = 2
    end
    it "should get a paginated list of messages with page 1" do
      login_as(@person)
      get "/rooms/#{@index_room.id}/messages", params: { page: 1, per_page: 2 }
      expect(response).to be_success
      expect(json["messages"].map { |m| m["id"] }).to eq([@messages.first.id.to_s, @messages[1].id.to_s])
    end
    it "should get only pinned messages with page 1" do
      login_as(@person)
      get "/rooms/#{@index_room.id}/messages", params: { page: 1, per_page: 2, pinned: "Yes" }
      expect(response).to be_success
      expect(json["messages"].map { |m| m["id"] }).to eq([@pinned_messages.first.id.to_s, @pinned_messages[1].id.to_s])
    end
    it "should get only nonpinned messages" do
      login_as(@person)
      get "/rooms/#{@index_room.id}/messages", params: { page: 1, pinned: "No" }
      expect(response).to be_success
      expect(json["messages"].count).to eq(8)
      expect(json["messages"].map { |m| m["id"] }.sort).to eq((@messages - @pinned_messages).map { |m| m.id.to_s }.sort)
    end
    it "should get all pinned and nonpinned messages" do
      login_as(@person)
      get "/rooms/#{@index_room.id}/messages", params: { page: 1, pinned: "All" }
      expect(response).to be_success
      expect(json["messages"].count).to eq(10)
      expect(json["messages"].map { |m| m["id"] }.sort).to eq(@messages.map { |m| m.id.to_s }.sort)
    end
  end
end
