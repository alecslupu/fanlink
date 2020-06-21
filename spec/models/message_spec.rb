# frozen_string_literal: true

RSpec.describe Message, type: :model do
  # before(:all) do
  #   @product = create(:product)
  #   @room = create(:room, product: @product)
  #   ActsAsTenant.current_tenant = @product
  # end

  let(:room) { create(:room) }
  context 'Valid' do
    it 'should create a valid message' do
      expect(build(:message)).to be_valid
    end
  end

  describe '#create' do
    it 'should not let you create a message without a room' do
      message = build(:message, room: nil)
      expect(message).not_to be_valid
      expect(message.errors[:room]).not_to be_empty
    end
    it 'should not let you create a message without a person' do
      message = build(:message, person: nil)
      expect(message).not_to be_valid
      expect(message.errors[:person]).not_to be_empty
    end
    it 'should let you create a message without a body' do
      message = build(:message, body: nil)
      expect(message).to be_valid
    end
  end

  describe '.for_date_range' do
    frozen_time = Time.zone.local(2018, 1, 10, 12, 0, 0)
    Timecop.freeze(frozen_time) do
      let!(:room) { create(:room, created_at: frozen_time - 1.month) }
      let!(:msg1) { create(:message, room: room, created_at: frozen_time) }
      let!(:msg2) { create(:message, room: room, created_at: frozen_time - 1.day) }
      let!(:msg3) { create(:message, room: room, created_at: frozen_time - 2.days) }
      let!(:old_msg) { create(:message, room: room, created_at: frozen_time - 10.days) }
      it 'should get messages for a date range with no limit' do
        msgs = Message.for_date_range(room, Date.parse('2018-01-02'), Date.parse('2018-01-10'))
        expect(msgs.to_a).to eq([msg1, msg2, msg3])
      end
      it 'should get messages for a date range with limit' do
        msgs = Message.for_date_range(room, Date.parse('2018-01-02'), Date.parse('2018-01-10'), 2)
        expect(msgs.to_a).to eq([msg1, msg2])
      end
    end
  end

  describe '.pinned' do
    before(:all) do
      @pintest_room = create(:room)
      @pinned_person1 = create(:person, pin_messages_from: true)
      @pinned_person2 = create(:person, pin_messages_from: true)
      @non_pinned_person = create(:person, pin_messages_from: false)
      @pinned_msg1 = create(:message, person: @pinned_person1, room: @pintest_room)
      @pinned_msg2 = create(:message, person: @pinned_person2, room: @pintest_room)
      @nonpinned_msg = create(:message, person: @non_pinned_person, room: @pintest_room)
    end
    it 'should give you only pinned messages if Yes is provided' do
      msgs = Message.pinned('Yes')
      expect(msgs.count).to eq(2)
      expect(msgs.map { |m| m.id }.sort).to eq([@pinned_msg1.id, @pinned_msg2.id].sort)
    end
    it 'should give you only nonpinned messages if No is provided' do
      msgs = Message.pinned('No')
      expect(msgs.count).to eq(1)
      expect(msgs.first.id).to eq(@nonpinned_msg.id)
    end
  end

  describe '.reported_action_needed' do
    it 'should give you the messages with pending reports' do
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

  describe '#visible?' do
    it 'should return true if message not hidden' do
      msg = build(:message)
      expect(msg.visible?).to be_truthy
    end
    it 'should return false if message hidden' do
      msg = build(:message, hidden: true)
      expect(msg.visible?).to be_falsey
    end
  end

  describe '#product' do
    it 'should return the product of the room' do
      msg = build(:message)
      expect(msg.product).to eq(msg.room.product)
    end
  end

  describe '.unblocked' do
    it 'should exclude messages from blocked users' do
      blocker = create(:person)
      blocked = create(:person)
      blocker.block(blocked)
      msg = create(:message, room: room, person_id: blocked.id)
      expect(Message.unblocked(blocker.blocked_people)).not_to include(msg)
    end
  end

  # TODO: auto-generated
  describe '#as_json' do
    it 'works' do
      message = build(:message)
      result = message.as_json
      expect(result).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe '#create_time' do
    it 'works' do
      message = Message.new
      result = message.create_time
      expect(result).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe '#mentions' do
    it 'works' do
      message = Message.new
      result = message.mentions
      expect(result).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe '#mentions=' do
    pending
  end

  # TODO: auto-generated
  describe '#name' do
    it 'works' do
      message = build(:message)
      expect(message.name).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe '#product' do
    it 'works' do
      message = build(:message)
      expect(message.product).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe '#reported?' do
    it 'works' do
      message = build(:message)
      expect(message.reported?).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe '#username' do
    it 'works' do
      message = build(:message)
      expect(message.username).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe '#visible?' do
    it 'works' do
      message = build(:message)
      expect(message.visible?).to be_truthy
    end
    pending
  end

  # TODO: auto-generated
  describe '#parse_content' do
    pending
  end

  # TODO: auto-generated
  describe '#pinned' do
    pending
  end

  describe '.delete_real_time' do
    it 'responds to ' do
      expect(Message.new).to respond_to(:delete_real_time)
    end
    pending
  end
  describe '.post' do
    it 'responds to ' do
      expect(Message.new).to respond_to(:post)
    end
    pending
  end
  describe '.private_message_push' do
    it 'responds to ' do
      expect(Message.new).to respond_to(:private_message_push)
    end
    pending
  end

  context 'Scopes' do
    describe '.id_filter' do
      it 'responds to' do
        expect(Message).to respond_to(:id_filter)
      end
      pending
    end
    describe '.person_filter' do
      it 'responds to' do
        expect(Message).to respond_to(:person_filter)
      end
      pending
    end
    describe '.room_id_filter' do
      it 'responds to' do
        expect(Message).to respond_to(:room_id_filter)
      end
      pending
    end
    describe '.body_filter' do
      it 'responds to' do
        expect(Message).to respond_to(:body_filter)
      end
      pending
    end
    describe '.created_after_filter' do
      it 'responds to' do
        expect(Message).to respond_to(:created_after_filter)
      end
      pending
    end
    describe '.created_before_filter' do
      it 'responds to' do
        expect(Message).to respond_to(:created_before_filter)
      end
      pending
    end
    describe '.reported_filter' do
      it 'responds to' do
        expect(Message).to respond_to(:reported_filter)
      end
      pending
    end

    # ====

    describe '.person_name_query' do
      it 'responds to' do
        expect(Message).to respond_to(:person_name_query)
      end
      pending
    end
    describe '.person_username_query' do
      it 'responds to' do
        expect(Message).to respond_to(:person_username_query)
      end
      pending
    end
    describe '.room_query' do
      it 'responds to' do
        expect(Message).to respond_to(:room_query)
      end
      pending
    end
    describe '.id_query' do
      it 'responds to' do
        expect(Message).to respond_to(:id_query)
      end
      pending
    end
    describe '.body_query' do
      it 'responds to' do
        expect(Message).to respond_to(:body_query)
      end
      pending
    end
    describe '.sorted_by' do
      it 'responds to' do
        expect(Message).to respond_to(:sorted_by)
      end
      pending
    end
    describe '.with_reported_status' do
      it 'responds to' do
        expect(Message).to respond_to(:with_reported_status)
      end
      pending
    end

  end
  describe '.options_for_reported_status_filter' do
    it 'responds to' do
      expect(Message).to respond_to(:options_for_reported_status_filter)
    end
    pending
  end
end
