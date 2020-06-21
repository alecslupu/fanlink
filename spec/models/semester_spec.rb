# frozen_string_literal: true

RSpec.describe Semester, type: :model do
  context "Associations" do
    describe "should belong to" do
      it "#product" do
        should belong_to(:product)
      end
    end

    describe "should have many" do
      it "#courses" do
        should have_many(:courses)
      end
    end
  end

  context "Validation" do
    describe "should create a valid semester" do
      it { expect(build(:semester)).to be_valid }
    end

    describe "should validate presense of" do
      it "#name" do
        should validate_presence_of(:name).with_message(_("A name is required."))
      end

      it "#description" do
        should validate_presence_of(:description).with_message(_("A description is required."))
      end

      it "#start_date" do
        should validate_presence_of(:start_date).with_message(_("A start date is required."))
      end
    end

    describe "should validate length of" do
      subject { build(:semester) }

      it "#name" do
        should validate_length_of(:name).is_at_least(3).is_at_most(26).with_message(_("Name must be between 3 and 26 characters."))
      end

      it "#description" do
        should validate_length_of(:description).is_at_least(3).is_at_most(500).with_message(_("Description must be between 3 and 500 characters."))
      end
    end

    describe "should validate uniqueness of" do
      describe "#name" do
        it "should allow the same name for multiple products" do
          sem1 = build(:semester, product: create(:product), name: "test_123")
          sem2 = build(:semester, product: create(:product), name: "test_123")

          expect(sem1).to be_valid
          expect(sem2).to be_valid
        end

        it "should not allow duplicate names for the same product" do
          product = create(:product)
          sem1 = create(:semester, product: product, name: "test_123")
          sem2 = build(:semester, product: product, name: "test_123")

          expect(sem1).to be_valid
          expect(sem2).not_to be_valid
          expect(sem2.errors[:name]).not_to be_empty
        end
      end
    end

    describe "should validate sensible dates" do
      it "should not have an end_date that is before the start_date" do
        semester = create(:semester)
        semester.end_date = semester.start_date - 1.day
        expect(semester).not_to be_valid
        expect(semester.errors[:end_date]).not_to be_empty
      end
    end
  end
end
