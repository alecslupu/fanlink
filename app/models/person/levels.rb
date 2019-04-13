class Person
  module Levels
    def level_earned
      points = level_progresses.first.try(:total) || 0
      determine_level(points)
    end

    def level_earned_from_progresses(progresses)
      points = progresses.first.try(:total) || 0
      determine_level(points)
    end

    def determine_level(points)
      Level.where(product_id: product.id).where("points <= ?", points).order(points: :desc).first
    end

    def level
      level_earned.as_json(only: %i[ id name internal_name points ], methods: %i[ picture_url ])
    end
  end
end
