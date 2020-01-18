require "spec_helper"

describe UserReferedListener do
  describe "#person_created" do
    it "dies silently if no user passed" do
      code = create(:person).reload.find_or_create_referal_code
      expect(UserReferedListener.person_created(nil, {referer: code.unique_code })).to be_falsey
    end
    it "dies silently if no refferer is passed" do
      expect(UserReferedListener.person_created(create(:person).id, {})).to be_falsey
    end
    it "it works " do
      code = create(:person).reload.find_or_create_referal_code
      expect(Referal::ReferedPerson.count).to eq(0)
      expect(UserReferedListener.person_created(create(:person).id, {referer: code.unique_code })).to be_truthy
      expect(Referal::ReferedPerson.count).to eq(1)
    end
  end
end

