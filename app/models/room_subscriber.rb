class RoomSubscriber < ApplicationRecord
  belongs_to :room
  belongs_to :person
  belongs_to :last_message, class_name: "Message", optional: true

  scope :for_product, ->(product) { joins(:person).where( people: { product_id: product.id }) }
end
