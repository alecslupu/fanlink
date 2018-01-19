class Person
  has_many :relationships, ->(person) { unscope(:where).where("requested_by_id = :id OR requested_to_id = :id", id: person.id) }

  module Relationships
    def can_status?(relationship, status)
      relationship.person_involved?(self) &&
        ((relationship.requested_by == self) ? [ "withdrawn", "unfriended" ].include?(status.to_s) :
                                            [ "denied", "friended", "unfriended" ].include?(status.to_s))
    end

    def friends
      relationships.where(status: :friended)
    end
  end
end
