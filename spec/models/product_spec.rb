RSpec.describe Product, type: :model do

  describe "#name" do
    it "should accept a good name format" do
      appl = create(:product, name: "My App")
      expect(appl).to be_valid
    end
    it "should not accept a format that is shorter than 3 characters" do
      appl = build(:product, name: "aa")
      expect(appl).not_to be_valid
      expect(appl.errors[:name]).not_to be_blank
    end
    it "should not accept a format that is longer than 60 characters" do
      appl = build(:product, name: "a" * 61)
      expect(appl).not_to be_valid
      expect(appl.errors[:name]).not_to be_blank
    end
  end

  describe "#subdomain" do
    it "should accept a good subdomain format" do
      appl = create(:product, subdomain: "goodone")
      expect(appl).to be_valid
    end
    it "should not accept a format that is shorter than 3 characters" do
      appl = build(:product, subdomain: "aa")
      expect(appl).not_to be_valid
      expect(appl.errors[:subdomain]).not_to be_blank
    end
    it "should not accept a format that is longer than 63 characters" do
      appl = build(:product, subdomain: "a" * 64)
      expect(appl).not_to be_valid
      expect(appl.errors[:subdomain]).not_to be_blank
    end
    it "should not start with nonalphanumeric" do
      appl = build(:product, subdomain: "-abcd")
      expect(appl).not_to be_valid
      expect(appl.errors[:subdomain]).not_to be_blank
    end
    it "should not end with nonalphanumeric" do
      appl = build(:product, subdomain: "abcd-")
      expect(appl).not_to be_valid
      expect(appl.errors[:subdomain]).not_to be_blank
    end
    it "should not contain chars other than alphanumeric or dash" do
      appl = build(:product, subdomain: "ab_cd")
      expect(appl).not_to be_valid
      expect(appl.errors[:subdomain]).not_to be_blank
    end
  end

end
