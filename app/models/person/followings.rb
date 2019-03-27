class Person
  has_many :active_followings, class_name:  "Following", foreign_key: "follower_id", dependent: :destroy

  has_many :passive_followings, class_name:  "Following", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_followings, source: :followed
  has_many :followers, through: :passive_followings, source: :follower

  module Followings
    def cache_key_follow_person(ver, app_source, user, person)
      [ver, "person", app_source, user,  person.id, person.updated_at.to_i]
    end

    def do_auto_follows
      Person.where(auto_follow: true).each do |p|
        follow(p)
      end
    end

    def follow(followed)
      active_followings.find_or_create_by(followed_id: followed.id)
    end

    def following?(someone)
      following.include?(someone)
    end

    def following_for_person(person)
      active_followings.find_by(followed_id: person.id)
    end

    def unfollow(someone)
      following.delete(someone)
    end
  end
end
