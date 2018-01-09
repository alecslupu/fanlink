class Person
  has_many :active_followings, class_name:  "Following", foreign_key: "follower_id", dependent: :destroy

  has_many :passive_followings, class_name:  "Following", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_followings, source: :followed
  has_many :followers, through: :passive_followings, source: :follower

  module Followings
    def follow(followed)
      active_followings.find_or_create_by(followed_id: followed.id)
    end

    def following?(someone)
      following.include?(someone)
    end

    def unfollow(someone)
      following.delete(someone)
    end
  end
end
