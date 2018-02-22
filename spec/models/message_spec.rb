RSpec.describe Message, type: :model do

  before(:all) do
    @product = create(:product)
    @room = create(:room, product: @product)
    ActsAsTenant.current_tenant = @product
  end

  describe "#create" do
    it "should not let you create a message without a room" do
      message = build(:message, room: nil)
      expect(message).not_to be_valid
      expect(message.errors[:room]).not_to be_empty
    end
    it "should not let you create a message without a person" do
      message = build(:message, person: nil)
      expect(message).not_to be_valid
      expect(message.errors[:person]).not_to be_empty
    end
    it "should let you create a message without a body" do
      message = build(:message, body: nil)
      expect(message).to be_valid
    end
  end

  describe ".for_date_range" do
    frozen_time = Time.local(2018, 1, 10, 12, 0, 0)
    Timecop.freeze(frozen_time) do
      let! (:room) { create(:room, created_at: frozen_time - 1.month) }
      let! (:msg1) { create(:message, room: room, created_at: frozen_time) }
      let! (:msg2) { create(:message, room: room, created_at: frozen_time - 1.day) }
      let! (:msg3) { create(:message, room: room, created_at: frozen_time - 2.days) }
      let! (:old_msg) { create(:message, room: room, created_at: frozen_time - 10.days) }
      it "should get messages for a date range with no limit" do
        msgs = Message.for_date_range(room, Date.parse("2018-01-02"), Date.parse("2018-01-10"))
        expect(msgs.to_a).to eq([msg1, msg2, msg3])
      end
      it "should get messages for a date range with limit" do
        msgs = Message.for_date_range(room, Date.parse("2018-01-02"), Date.parse("2018-01-10"), 2)
        expect(msgs.to_a).to eq([msg1, msg2])
      end
    end
  end

  describe ".reported_action_needed" do
    it "should give you the messages with pending reports" do
      msg_in = create(:message)
      create(:message_report, message: msg_in)
      msg_in2 = create(:message)
      create(:message_report, message: msg_in2)
      msg_out = create(:message)
      msg_out2 = create(:message)
      create(:message_report, message: msg_out2, status: :no_action_needed)
      messages = Message.reported_action_needed
      expect(messages.size).to eq(2)
      expect(messages).to include(msg_in)
      expect(messages).to include(msg_in2)
    end
  end

  describe "#visible?" do
    it "should return true if message not hidden" do
      msg = create(:message)
      expect(msg.visible?).to be_truthy
    end
    it "should return false if message hidden" do
      msg = create(:message, hidden: true)
      expect(msg.visible?).to be_falsey
    end
  end

  describe "#product" do
    it "should return the product of the room" do
      msg = create(:message)
      expect(msg.product).to eq(msg.room.product)
    end
  end

  describe ".unblocked" do
    it "should exclude messages from blocked users" do
      blocker = create(:person)
      blocked = create(:person)
      blocker.block(blocked)
      msg = create(:message, room: @room, person_id: blocked.id)
      expect(Message.unblocked(blocker.blocked_people)).not_to include(msg)
    end
  end

end
