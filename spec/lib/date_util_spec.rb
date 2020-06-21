# frozen_string_literal: true

describe "DateUtil" do
  describe ".valid_date_string" do
    it "should return true for good date" do
      expect(DateUtil.valid_date_string?("2018-12-31")).to be_truthy
    end
    it "should return true for another good date" do
      expect(DateUtil.valid_date_string?("2018-1-31")).to be_truthy
    end
    it "should return true for yet another good date" do
      expect(DateUtil.valid_date_string?("2018-1-1")).to be_truthy
    end
    it "should return false for really bad string" do
      expect(DateUtil.valid_date_string?("this can't be right")).to be_falsey
    end
    it "should return false for really bad year" do
      expect(DateUtil.valid_date_string?("foo-12-31")).to be_falsey
    end
    it "should return false for really bad month" do
      expect(DateUtil.valid_date_string?("2018-foo-31")).to be_falsey
    end
    it "should return false for really bad day" do
      expect(DateUtil.valid_date_string?("2018-12-foo")).to be_falsey
    end
    it "should return false for a bad year" do
      expect(DateUtil.valid_date_string?("1532-12-31")).to be_falsey
    end
    it "should return false for a bad month" do
      expect(DateUtil.valid_date_string?("2018-13-31")).to be_falsey
    end
    it "should return false for a bad day" do
      expect(DateUtil.valid_date_string?("2018-2-30")).to be_falsey
    end
  end
end
