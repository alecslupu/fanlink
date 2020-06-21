# frozen_string_literal: true

RSpec.describe Quest, type: :model do
  context "Validation" do
    describe "should create a valid quest" do
      it do
        expect(create(:quest)).to be_valid
      end
    end
    describe "should validate presence of"
    it "#name" do
      should validate_presence_of(:name).with_message(_("Name is required."))
    end
    it "#description" do
      should validate_presence_of(:description).with_message(_("A quest description is required."))
    end
    it "#starts_at" do
      should validate_presence_of(:starts_at).with_message(_("Starting date and time is required."))
    end
    it "#date_sanity" do
      quest = build(:quest, starts_at: DateTime.current, ends_at: DateTime.current - 1.hour)
      quest.valid?
      expect(quest.errors[:ends_at]).to include(_("Start date cannot be after end date."))

      quest.ends_at = DateTime.current + 1.hour
      quest.valid?
      expect(quest.errors[:ends_at]).not_to include(_("Start date cannot be after end date."))
    end
  end

  context "Accepted Nested Attributes" do
    describe "should accept attributes for" do
      it "steps" do
        should accept_nested_attributes_for(:steps)
      end
    end
  end

  context "Enumeration" do
    it "#should define status enumerables with values of disabled, enabled, active, and deleted" do
      should define_enum_for(:status).with([:disabled, :enabled, :active, :deleted])
    end
  end

  context "Scopes" do
    it "should return quests for the given dates using in_date_range scope" do
    end
    it "should return quests for the given product using for_product scope" do
    end

    describe "#for_product" do
      it "responds to method " do
        expect(Quest).to respond_to(:for_product)
      end
      pending
    end
    describe "#ordered" do
      it "responds to method " do
        expect(Quest).to respond_to(:ordered)
      end
      pending
    end

    describe "#in_testing" do
      it "responds to method " do
        expect(Quest).to respond_to(:in_testing)
      end
      pending
    end

    describe "#running" do
      it "responds to method " do
        expect(Quest).to respond_to(:running)
      end
      pending
    end
    describe "#id_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:id_filter)
      end
      pending
    end

    describe "#product_id_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:product_id_filter)
      end
      pending
    end
    describe "#product_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:product_filter)
      end
      pending
    end

    describe "#name_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:name_filter)
      end
      pending
    end

    describe "#description_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:description_filter)
      end
      pending
    end

    describe "#starts_at_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:starts_at_filter)
      end
      pending
    end

    describe "#ends_at_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:ends_at_filter)
      end
      pending
    end

    describe "#posted_after_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:posted_after_filter)
      end
      pending
    end

    describe "#posted_before_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:posted_before_filter)
      end
      pending
    end

    describe "#status_filter" do
      it "responds to method " do
        expect(Quest).to respond_to(:status_filter)
      end
      pending
    end
  end

  context "Methods" do
    describe "#running?" do
      pending
    end
  end

  context "Filters" do
    it "#id_filter" do
    end
    it "#product_id_filter" do
    end
    it "#product_filter" do
    end
    it "#name_filter" do
    end
    it "#description_filter" do
    end
    it "#starts_at_filter" do
    end
    it "#ends_at_filter" do
    end
    it "#post_after_filter" do
    end
    it "#post_before_filter" do
    end
    it "#status_filter" do
    end
  end
end
