# frozen_string_literal: true
RSpec.describe PortalAccess, type: :model do
  context "Validation" do
    describe "should create a valid portal access" do
      it do
        expect(build(:portal_access)).to be_valid
      end
    end
  end

  # TODO: auto-generated
  describe "#summarize" do
    it "works" do
      portal_access = PortalAccess.new
      result = portal_access.summarize
      expect(result).not_to be_nil
    end
  end
end
