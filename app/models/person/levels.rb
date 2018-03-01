class Person
  module Levels
    def level_earned
      points = badges.sum(:point_value)
      if points == 0
        nil
      else
        Level.where("points <= ?", points).order(points: :desc).first
      end
    end

    def level
      level_earned.as_json(only: %i[ id name internal_name points ], methods: %i[ picture_url ])
    end
  end
end
