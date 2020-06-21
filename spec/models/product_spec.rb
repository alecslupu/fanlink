# frozen_string_literal: true

RSpec.describe Product, type: :model do
  context "Validation" do
    it "should create a valid product" do
      expect(build(:product)).to be_valid
    end
  end

  describe "#destroy" do
    it "should not let you destroy a product that has people" do
      per = create(:person)
      prod = per.product
      prod.destroy
      expect(prod).to exist_in_database
    end
  end

  describe "#people_count" do
    pending
  end

  describe "#name" do
    it "should accept a good name format" do
      appl = build(:product, name: "My App")
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
    it "should require unique name" do
      app1 = create(:product, name: "abc")
      app2 = build(:product, name: "abc")
      expect(app2).not_to be_valid
      expect(app2.errors[:name]).not_to be_empty
    end
  end

  describe "#internal_name" do
    it "should accept a good internal name" do
      appl = build(:product, internal_name: "good_one")
    end
    it "should not accept an internal name that is shorter than 3 characters" do
      appl = build(:product, internal_name: "aa")
      expect(appl).not_to be_valid
      expect(appl.errors[:internal_name]).not_to be_blank
    end
    it "should not accept an internal name that is longer than 30 characters" do
      appl = build(:product, internal_name: "a" * 31)
      expect(appl).not_to be_valid
      expect(appl.errors[:internal_name]).not_to be_blank
    end
    it "should not contain dash" do
      appl = build(:product, internal_name: "-abcd")
      expect(appl).not_to be_valid
      expect(appl.errors[:internal_name]).not_to be_blank
    end
    it "should not contain chars other than alphanumeric or underscore" do
      appl = build(:product, internal_name: "ab?cd")
      expect(appl).not_to be_valid
      expect(appl.errors[:internal_name]).not_to be_blank
    end
    it "should require unique internal name" do
      app1 = create(:product, internal_name: "abc")
      app2 = build(:product, internal_name: "abc")
      expect(app2).not_to be_valid
      expect(app2.errors[:internal_name]).not_to be_empty
    end
  end

  describe "#to_s" do
    it "should return the product internal name" do
      prod = build(:product)
      expect(prod.to_s).to eq(prod.internal_name)
    end
  end
end
