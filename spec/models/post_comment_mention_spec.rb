# frozen_string_literal: true
RSpec.describe PostCommentMention, type: :model do
  context "Validation" do
    describe "should create a valid post comment mention" do
      it do
        expect(build(:post_comment_mention)).to be_valid
      end
    end
  end
end
