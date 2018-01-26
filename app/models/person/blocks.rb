class Person
  has_many :blocks_by,  class_name: "Block", foreign_key: "blocker_id", dependent: :destroy
  has_many :blocks_on, class_name: "Block", foreign_key: "blocked_id", dependent: :destroy

  has_many :blocked_people, through: :blocks_by, source: :blocked
  has_many :blocked_by_people, through: :blocks_on, source: :blocker

  module Blocks
    # def follow(followed)
    #   active_followings.find_or_create_by(followed_id: followed.id)
    # end
    #
    # def following?(someone)
    #   following.include?(someone)
    # end
    #
    # def following_for_person(person)
    #   active_followings.find_by(followed_id: person.id)
    # end
    #
    # def unfollow(someone)
    #   following.delete(someone)
    # end
  end
end
