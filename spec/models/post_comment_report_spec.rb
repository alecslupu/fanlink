# frozen_string_literal: true
RSpec.describe PostCommentReport, type: :model do
  before(:each) do
    @product = create(:product)
    ActsAsTenant.current_tenant = @product
    @post_comment = create(:post_comment)
  end

  context "Scopes" do
    describe "#for_product" do
      it "responds" do
        expect(PostCommentReport).to respond_to(:for_product)
      end
      pending
    end
    describe "#status_filter" do
      it "responds" do
        expect(PostCommentReport).to respond_to(:status_filter)
      end
      pending
    end
  end

  context "Valid" do
    it "should create a valid post comment report" do
      expect(create(:post_comment_report)).to be_valid
    end
    context "Validation" do
      subject { create(:post_comment_report) }
      it { is_expected.to define_enum_for(:status).with(PostCommentReport.statuses.keys) }
      it { should validate_length_of(:reason).is_at_most(500).with_message(_("Reason cannot be longer than 500 characters.")) }
    end

    context "validates inclusion" do
      it do
        PostCommentReport.statuses.keys.each do |status|
          expect(build(:post_comment_report, status: status)).to be_valid
        end

        expect { build(:post_comment_report, status: :invalid_status_form_spec) }.to raise_error(/is not a valid status/)
      end
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

  context "Associations" do
    it { should belong_to(:post_comment) }
    it { should belong_to(:person) }
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

  describe "valid_status?" do
    it { expect(PostCommentReport.valid_status?("pending")).to be_truthy }
    it { expect(PostCommentReport.valid_status?("no_action_needed")).to be_truthy }
    it { expect(PostCommentReport.valid_status?("comment_hidden")).to be_truthy }
    it { expect(PostCommentReport.valid_status?("no_status")).to be_falsey }
  end

  # TODO: auto-generated
  describe "#create_time" do
    it "works" do
      post_comment_report = PostCommentReport.new
      result = post_comment_report.create_time
      expect(result).not_to be_nil
    end
    pending
  end
end
