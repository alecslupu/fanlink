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


require 'rails_helper'

RSpec.describe ConfigItem, type: :model do
  context 'Validation' do
    describe 'should create a valid course' do
      it { expect(build(:string_config_item)).to be_valid }
      it { expect(build(:array_config_item)).to be_valid }
      it { expect(build(:boolean_config_item)).to be_valid }
      it { expect(build(:root_config_item)).to be_valid }
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
