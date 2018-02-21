RSpec.describe PostReport, type: :model do

  before(:all) do
    @product = create(:product)
    ActsAsTenant.current_tenant = @product
    @post = create(:post)
  end

  describe "#create" do
    it "should create a report" do
      expect(create(:post_report)).to be_valid
    end
    it "should not let you create a post report without a post" do
      report = build(:post_report, post: nil)
      expect(report).not_to be_valid
      expect(report.errors[:post]).not_to be_empty
    end
    it "should not let you create a post report without a person" do
      report = build(:post_report, person: nil)
      expect(report).not_to be_valid
      expect(report.errors[:person]).not_to be_empty
    end
  end

  describe "#reason" do
    it "should not let you give a reason more than 500 characters in length" do
      report = build(:post_report, reason: "a" * 501)
      expect(report).not_to be_valid
      expect(report.errors[:reason]).not_to be_empty
    end
  end
end
