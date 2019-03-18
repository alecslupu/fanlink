RSpec.describe EventCheckin, type: :model do
  context "Validation" do
    describe "should create a valid event checkin" do
      it do
        expect(create(:event_checkin)).to be_valid
      end
    end
    describe "#product_match" do
      it "adds error message" do
        pending("multiple atempts tried. No managed to see the error")
      end
      it "passes" do
        product = create(:product)
        person = create(:person, product: product)
        event = create(:event, product: product)
        expect(build(:event_checkin, event: event, person: person)).to be_valid
      end
    end
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#belongs_to" do
        should belong_to(:event)
        should belong_to(:person)
      end
    end
  end
end
