# frozen_string_literal: true

# == Schema Information
#
# Table name: config_items
#
#  id               :bigint           not null, primary key
#  product_id       :bigint
#  item_key         :string
#  item_value       :string
#  type             :string
#  enabled          :boolean          default(TRUE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  parent_id        :integer
#  lft              :integer          default(0), not null
#  rgt              :integer          default(0), not null
#  depth            :integer          default(0), not null
#  children_count   :integer          default(0)
#  item_url         :string
#  item_description :string
#


RSpec.describe IntegerConfigItem, type: :model do
  context 'callbacks' do
    describe '#strip_blanks' do
      it 'removes whitespaces' do
        config_item = IntegerConfigItem.create(product: create(:product), item_key: 'key', item_value: ' 22 ')
        expect(config_item.item_value).to eq('22')
      end
    end
  end
end
