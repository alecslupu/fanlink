include MessagingHelpers

describe "Messaging" do

  before(:all) do
    @person = create(:person)
    @room = create(:room)
    @room.members << @person
    @fb_stub = FBStub.new
  end
  before(:each) do |example|
    unless example.metadata[:skip_before]
      expect(Firebase::Client).to receive(:new).and_return(@fb_stub)
      @implementer = Implementer.new
    end
  end

  describe "#clear_message_counter" do
    it "should clear the message count" do
      expect_any_instance_of(FBStub).to receive(:set)
        .with("#{person_path(@person)}/message_counts/#{@room.id}", 0)
      @implementer.clear_message_counter(@room, @person)
    end
  end

  describe "#delete_message" do
    it "should set deleted message id" do
      msg = create(:message, hidden: true)
      expect_any_instance_of(FBStub).to receive(:set)
        .with("#{msg.room.product.internal_name}/rooms/#{msg.room.id}/last_deleted_message_id", msg.id)
      @implementer.delete_message(msg)
    end
  end

  describe "#delete_post" do
    it "should set deleted post id if there are people to be notified" do
      post = create(:post)
      tbn = [@person]
      expect_any_instance_of(FBStub).to receive(:update)
        .with("", { "#{person_path(@person)}/deleted_post_id" => post.id }).and_return(Response.new)
      @implementer.delete_post(post, tbn)
    end
    it "should do nothing if there are no people to be notified", :skip_before do
      post = create(:post)
      tbn = []
      expect(Firebase::Client).not_to receive(:new)
      expect_any_instance_of(FBStub).not_to receive(:update)
      expect(Implementer.new.delete_post(post, tbn)).to be_truthy
    end
  end

  describe "#delete_room" do
    it "should deleted public room" do
      room = create(:room, public: true)
      expect_any_instance_of(FBStub).to receive(:delete).with(room_path(room))
      @implementer.delete_room(room)
    end
    it "should delete private room" do
      expect_any_instance_of(Implementer).to receive(:delete_room_for_member).with(@room, @person)
      @implementer.delete_room(@room)
    end
  end

  describe "#delete_room_for_member" do
    it "should deleted room" do
      expect_any_instance_of(FBStub).to receive(:set).with("#{person_path(@person)}/deleted_room_id", @room.id)
      @implementer.delete_room_for_member(@room, @person)
    end
  end

  describe "#new_private_room" do
    it "should notify new private room" do
      room = create(:room)
      room.members << @person
      expect_any_instance_of(FBStub).to receive(:set).with("#{person_path(@person)}/new_room_id", room.id)
      @implementer.new_private_room(room)
    end
  end

  describe "#post_message" do
    it "should post a message to a public room" do
      room = create(:room, public: true)
      msg = create(:message, room: room)
      expect_any_instance_of(FBStub).to receive(:set).with("#{room_path(room)}/last_message", msg.as_json).and_return(Response.new)
      @implementer.post_message(msg)
    end
    it "should post a message to a private room" do
      msg = create(:message, room: @room)
      expect_any_instance_of(FBStub).to receive(:set).with("#{room_path(@room)}/last_message_id", msg.id).and_return(Response.new)
      @implementer.post_message(msg)
    end
  end

  describe "#post_post" do
    it "should post when there are people to be notified" do
      post = create(:post)
      tbn = [@person]
      expect_any_instance_of(FBStub).to receive(:update)
        .with("", { "#{person_path(@person)}/last_post_id" => post.id }).and_return(Response.new)
      @implementer.post_post(post, tbn)
    end
    it "should do nothing if there are no people to be notified", :skip_before do
      post = create(:post)
      tbn = []
      expect(Firebase::Client).not_to receive(:new)
      expect_any_instance_of(FBStub).not_to receive(:update)
      expect(Implementer.new.post_post(post, tbn)).to be_truthy
    end
  end

  describe "#set_message_counters" do
    it "should update message counters for the right users" do
      room = create(:room)
      eu = create(:person)
      eumem = eu.room_memberships.create(room: room)
      mem = @person.room_memberships.create(room: room)
      expect_any_instance_of(FBStub).to receive(:update).with("", "#{person_path(@person)}/message_counts/#{room.id}" => mem.message_count + 1).and_return(Response.new)
      expect_any_instance_of(FBStub).not_to receive(:update).with("", "#{person_path(eu)}/message_counts/#{room.id}" => eumem.message_count + 1)
      @implementer.set_message_counters(room, eu)
    end
  end

  describe "#update_relationship_count" do
    it "should update the relationship count" do
      expect_any_instance_of(FBStub).to receive(:set).with("#{person_path(@person)}/friend_request_count", @person.friend_request_count).and_return(Response.new)
      @implementer.update_relationship_count(@person)
    end
  end

private

  def person_path(person)
    "#{person.product.internal_name}/users/#{person.id}"
  end

  def room_path(room)
    "#{room.product.internal_name}/rooms/#{room.id}"
  end
end