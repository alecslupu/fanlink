# frozen_string_literal: true
RSpec.describe IntegerConfigItem, type: :model do
  context "callbacks" do
    describe "#strip_blanks" do
      it "removes whitespaces" do
        config_item = IntegerConfigItem.create(product: create(:product), item_key: "key", item_value: " 22 ")
        expect(config_item.item_value).to eq("22")
      end
    end
  end
end
