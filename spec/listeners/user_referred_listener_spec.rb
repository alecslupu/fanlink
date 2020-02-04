require "spec_helper"

describe UserReferredListener do
  describe "#person_created" do
    it "dies silently if no user passed" do
      code = create(:person).reload.find_or_create_referral_code
      expect(UserReferredListener.person_created(nil, {referrer: code.unique_code })).to be_falsey
    end
    it "dies silently if no refferer is passed" do
      expect(UserReferredListener.person_created(create(:person).id, {})).to be_falsey
    end
    it "it works " do
      code = create(:person).reload.find_or_create_referral_code
      expect(Referral::ReferredPerson.count).to eq(0)
      expect(UserReferredListener.person_created(create(:person).id, {referrer: code.unique_code })).to be_truthy
      expect(Referral::ReferredPerson.count).to eq(1)
    end
  end
end
