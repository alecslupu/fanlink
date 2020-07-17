# frozen_string_literal: true

# == Schema Information
#
# Table name: person_poll_options
#
#  id             :bigint           not null, primary key
#  person_id      :integer          not null
#  poll_option_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PersonPollOption < ApplicationRecord
  belongs_to :poll_option, counter_cache: true
  belongs_to :person
  validates_uniqueness_of :poll_option_id, scope: :person_id

  scope :for_product, ->(product) { joins(:person).where(people: { product_id: product.id }) }
end
