# frozen_string_literal: true

RSpec.describe EventCheckin, type: :model do
  context 'Validation' do
    describe 'should create a valid event checkin' do
      it { expect(build(:event_checkin)).to be_valid }
    end
    describe '#product_match' do
      it 'adds error message' do
        person = create(:person)
        old_tenant = ActsAsTenant.current_tenant
        ActsAsTenant.current_tenant = create(:product)
        event = create(:event)
        event_checkin = build(:event_checkin, event: event, person: person)
        expect(event_checkin).not_to be_valid
        ActsAsTenant.current_tenant = old_tenant
      end
      it 'passes' do
        product = create(:product)
        person = create(:person, product: product)
        event = create(:event, product: product)
        expect(build(:event_checkin, event: event, person: person)).to be_valid
      end
    end
  end
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#belongs_to' do
        should belong_to(:event)
        should belong_to(:person)
      end
    end
  end

  # TODO: auto-generated
  describe '#product_match' do
    pending
  end
end
