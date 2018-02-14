describe "Push" do

  before(:all) do
    @fbcm_stub = FBCMStub.new
    @person = create(:person)
    
  end

  before(:each) do |example|
    unless example.metadata[:skip_before]
      expect(FCM).to receive(:new).with(FIREBASE_CM_KEY).and_return(@fbcm_stub)
      @implementer = Implementer.new
    end
  end

  describe "#friend_request_accepted_push" do
    it "should send push" do

      expect_any_instance_of(FBCMStub).to receive(:send).with
    end


  end


end