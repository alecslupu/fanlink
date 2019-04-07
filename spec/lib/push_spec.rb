include ActionView::Helpers::TextHelper #truncate
include PushHelpers

describe "Push" do
  before(:all) do
    @fbcm_stub = FBCMStub.new
    @person = create(:person)
    @tokens = [create(:notification_device_id, person: @person).device_identifier]
  end

  before(:each) do |example|
    unless example.metadata[:skip_before]
      expect(FCM).to receive(:new).with(FIREBASE_CM_KEY).and_return(@fbcm_stub)
      @implementer = PushHelpers::Implementer.new
    end
  end

  describe "#friend_request_accepted_push" do
    it "should send push" do
      with_person = create(:person)

      ActsAsTenant.with_tenant(with_person.product) do
        rel = create(:relationship, requested_by: @person, requested_to: with_person, status: :friended)
        expect_any_instance_of(FBCMStub).to receive(:send).with(@tokens,
                                                                get_options("Friend Request Accepted",
                                                                            "#{with_person.username} accepted your friend request",
                                                                            "friend_accepted",
                                                                            person_id: with_person.id))
        @implementer.friend_request_accepted_push(rel)
      end
    end
  end
  describe "#friend_request_received_push" do
    it "should send push" do
      from_person = create(:person)
      ActsAsTenant.with_tenant(from_person.product) do
        create(:relationship, requested_by: from_person, requested_to: @person)
        expect_any_instance_of(FBCMStub).to receive(:send).with(@tokens,
                                                                get_options("New Friend Request",
                                                                            "#{from_person.username} sent you a friend request",
                                                                            "friend_requested",
                                                                            person_id: from_person.id))
        @implementer.friend_request_received_push(from_person, @person)
      end
    end
  end
  describe "#private_message_push" do
    it "should send push" do
      from_person = create(:person)
      ActsAsTenant.with_tenant(from_person.product) do
        rec2 = create(:person)
        tokens = @tokens
        tokens << create(:notification_device_id, person: rec2).device_identifier
        room = create(:room)
        room.members << @person << rec2
        msg = create(:message, room: room, person_id: from_person.id)
        expect_any_instance_of(FBCMStub).to receive(:send).with(tokens,
                                                                get_options(from_person.username,
                                                                            truncate(msg.body),
                                                                            "message_received",
                                                                            room_id: room.id,
                                                                            message_id: msg.id))
        @implementer.private_message_push(msg)
      end
    end
  end
end
