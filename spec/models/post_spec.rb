require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "#body" do
    it "should not let you create a disembodied nil post" do
      post = build(:post, body: nil)
      expect(post).not_to be_valid
      expect(post.errors[:body]).not_to be_empty
    end
    it "should not let you create a disembodied empty string post" do
      post = build(:post, body: "")
      expect(post).not_to be_valid
      expect(post.errors[:body]).not_to be_empty
    end
  end
  describe "#create" do
    it "should be valid" do
      expect(create(:post)).to be_valid
    end
  end
  describe "#starts_at" do
    it "should not let you create a post that starts after it ends" do
      post = build(:post, starts_at: Time.now + 1.day, ends_at: Time.now + 23.hours)
      expect(post).not_to be_valid
      expect(post.errors[:starts_at]).not_to be_empty
    end
  end
end
