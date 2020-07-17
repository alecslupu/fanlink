# frozen_string_literal: true

# == Schema Information
#
# Table name: hacked_metrics
#
#  id             :bigint           not null, primary key
#  product_id     :integer          not null
#  person_id      :integer          not null
#  action_type_id :integer          not null
#  identifier     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#


require 'rails_helper'

RSpec.describe HackedMetric, type: :model do
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#belong_to' do
        should belong_to(:product)
        should belong_to(:person)
        should belong_to(:action_type)
      end
    end
  end
end
