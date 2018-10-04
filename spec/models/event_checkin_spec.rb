RSpec.describe EventCheckin, type: :model do
  context "Validation" do
    describe "should create a valid event checkin" do
      it do
        expect(create(:event_checkin)).to be_valid
      end
    end
  end
end
