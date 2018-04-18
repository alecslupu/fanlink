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
  end
end
