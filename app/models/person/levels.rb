class Person
  module Levels
    def level
      points = badges.sum(:point_value)
      if points == 0
        nil
      else
        Level.where("points <= ?", points).order(points: :desc).first
      end
    end
  end
end
