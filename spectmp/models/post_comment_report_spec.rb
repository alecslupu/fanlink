RSpec.describe PostCommentReport, type: :model do

  before(:all) do
    @product = create(:product)
    ActsAsTenant.current_tenant = @product
    @post_comment = create(:post_comment)
  end

  describe "#create" do
    it "should create a report" do
      expect(create(:post_comment_report)).to be_valid
    end
    it "should not let you create a post comment report without a post comment" do
      report = build(:post_comment_report, post_comment: nil)
      expect(report).not_to be_valid
      expect(report.errors[:post_comment]).not_to be_empty
    end
    it "should not let you create a post comment report without a person" do
      report = build(:post_comment_report, person: nil)
      expect(report).not_to be_valid
      expect(report.errors[:person]).not_to be_empty
    end
  end

  describe "#for_product" do
    it "should get post comment reports only involving the indicated product" do
      prod = create(:product)
      ActsAsTenant.with_tenant(prod) do
        post_comment = create(:post_comment, person: create(:person, product: prod))
        report_other = create(:post_comment_report, post_comment: post_comment)
      end
      report_wanted = create(:post_comment_report)
      reps = PostCommentReport.for_product(@product)
      expect(reps.size).to eq(1)
      expect(reps.first).to eq(report_wanted)
    end
  end

  describe "#reason" do
    it "should not let you give a reason more than 500 characters in length" do
      report = build(:post_comment_report, reason: "a" * 501)
      expect(report).not_to be_valid
      expect(report.errors[:reason]).not_to be_empty
    end
  end
end
