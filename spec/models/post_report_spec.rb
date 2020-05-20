# frozen_string_literal: true
RSpec.describe PostReport, type: :model do

  before(:each) do
    @product = create(:product)
    ActsAsTenant.current_tenant = @product
    @post = create(:post)
  end

  context "Valid" do
    it "should create a valid post report" do
      expect(build(:post_report)).to be_valid
    end
  end

  context "Scopes" do

    describe ".status_filter" do
      it do
        expect(PostReport).to respond_to(:status_filter)
      end
      pending
    end

  end

  describe "#create" do
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

  describe "#for_product" do
    it "should get post reprots only involving the indicated product" do
      prod = create(:product)
      post = nil
      ActsAsTenant.with_tenant(prod) do
        post = create(:post)
      end
      report_wanted = create(:post_report, post: @post)
      report_other = create(:post_report, post: post)
      reps = PostReport.for_product(@product)
      expect(reps.size).to eq(1)
      expect(reps.first).to eq(report_wanted)
    end
  end

  describe "#reason" do
    it "should not let you give a reason more than 500 characters in length" do
      report = build(:post_report, reason: "a" * 501)
      expect(report).not_to be_valid
      expect(report.errors[:reason]).not_to be_empty
    end
  end

  describe "#create_time" do
    pending
  end

  # TODO: auto-generated
  describe "#valid_status?" do
    pending
  end
end
