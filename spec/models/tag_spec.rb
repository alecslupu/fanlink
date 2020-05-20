# frozen_string_literal: true
RSpec.describe Tag, type: :model do
  context "Associations" do
    describe "should belong to" do
      it "#product" do
        should belong_to(:product)
      end
    end

    describe "should have many" do
      it "#post_tags" do
        should have_many(:post_tags)
      end

      it "#posts" do
        should have_many(:posts).through(:post_tags)
      end
    end
  end

  context "Validation" do
    describe "should create a valid tag" do
      it do
        expect(build(:tag)).to be_valid
      end
    end
  end
end
