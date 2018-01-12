class Person

  has_many :relationships, ->(person) { unscope(:where).where("requested_by_id = :id OR requested_to_id = :id", id: person.id) }

  module Relationships
    def friends
      relationships.where(status: :friended)
    end
  end
end
