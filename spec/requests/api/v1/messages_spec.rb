describe "Messages (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @room = create(:room, public: true, status: :active, product: @product)
  end

  describe "#create" do
    it "should create a new message in a public room" do
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
end