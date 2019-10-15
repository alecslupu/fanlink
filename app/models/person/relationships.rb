class Person
  has_many :relationships, ->(person) { unscope(:where).where("requested_by_id = :id OR requested_to_id = :id", id: person.id) }

  module Relationships
    def friend_request_count
      relationships.where(requested_to: self).where(status: :requested).count
    end

    def friends
      relationships.where(status: :friended)
    end
  end
end
