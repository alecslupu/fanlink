describe "MessageReports (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    room = create(:room, public: true, status: :active, product: @product)
    @message = create(:message, room: room)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new report in a public room" do
      login_as(@person)
      reason = "I don't like you"
      post "/rooms/#{@message.room.id}/message_reports", params: { message_report: { message_id: @message.id, reason: reason } }
      expect(response).to be_success
      report = MessageReport.last
      expect(report.message).to eq(@message)
      expect(report.person).to eq(@person)
      expect(report.reason).to eq(reason)
    end
    it "should not create a report of a private message" do
      login_as(@person)
      room = create(:room, public: false)
      msg = create(:message, room: room)
      reason = "I don't like you"
      post "/rooms/#{msg.room.id}/message_reports", params: { message_report: { message_id: msg.id, reason: reason } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("cannot report a private message")
    end
    it "should not create a report if not logged in" do
      room = create(:room, public: false)
      msg = create(:message, room: room)
      reason = "I don't like you"
      post "/rooms/#{msg.room.id}/message_reports", params: { message_report: { message_id: msg.id, reason: reason } }
      expect(response).to be_unauthorized
    end
    it "should not create a report for a message from a different product" do
      login_as(@person)
      room = create(:room, product: create(:product))
      msg = create(:message, room: room)
      post "/rooms/#{msg.room.id}/message_reports", params: { message_report: { message_id: msg.id } }
      expect(response).to be_not_found
    end
  end

  describe "#update" do
    let(:report) { create(:message_report, message: @message) }
    it "should update a message report" do
      admin = create(:person, product: report.message.room.product, role: :admin)
      login_as(admin)
      patch "/message_reports/#{report.id}", params: { message_report: { status: "no_action_needed" } }
      expect(response).to be_success
      expect(report.reload.status).to eq("no_action_needed")
    end
    it "should not update a message report to an invalid status" do
      admin = create(:person, product: report.message.room.product, role: :admin)
      login_as(admin)
      patch "/message_reports/#{report.id}", params: { message_report: { status: "punting" } }
      expect(response).to be_unprocessable
    end
    it "should not update a message report if not logged in" do
      report = create(:message_report, message: @message)
      patch "/message_reports/#{report.id}", params: { message_report: { status: "pending" } }
      expect(response).to be_unauthorized
    end
    it "should not update a message report if not logged in" do
      report = create(:message_report, message: @message)
      patch "/message_reports/#{report.id}", params: { message_report: { status: "pending" } }
      expect(response).to be_unauthorized
    end
    it "should not update a message report if not admin" do
      login_as(create(:person, product: @product, role: :normal))
      patch "/message_reports/#{report.id}", params: { message_report: { status: "pending" } }
      expect(response).to be_unauthorized
    end
  end


end
