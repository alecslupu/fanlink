RSpec.describe PortalAccess, type: :model do
  context "Validation" do
    describe "should create a valid portal access" do
      it do
        expect(create(:portal_access)).to be_valid
      end
    end
  end
end
